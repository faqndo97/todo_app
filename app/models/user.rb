class User < ApplicationRecord
  MINIMUM_PASSWORD_LENGTH = 8

  has_secure_password

  enum :locale, I18n.available_locales.map(&:to_s).index_by(&:itself), default: :en, suffix: true, validate: true

  generates_token_for :email_verification, expires_in: 2.days do
    email
  end

  generates_token_for :password_reset, expires_in: 20.minutes do
    password_salt.last(10)
  end

  belongs_to :invited_by, class_name: User.name, foreign_key: :invited_by_id, optional: true
  has_many :sessions, dependent: :destroy
  has_many :owned_lists, class_name: List.name, foreign_key: :user_id, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :list_memberships, class_name: List::Membership.name, foreign_key: :user_id, dependent: :destroy
  has_many :lists, through: :list_memberships

  validates :first_name, :last_name, presence: true, if: -> { !invited? || invited? && invitation_confirmed? }
  validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :password, allow_nil: true, length: {minimum: MINIMUM_PASSWORD_LENGTH}

  normalizes :email, with: -> { _1.strip.downcase }
  normalizes :first_name, with: -> { _1.strip.downcase }
  normalizes :last_name, with: -> { _1.strip.downcase }

  before_update if: :email_changed? do
    self.verified = false
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
  end

  after_update if: -> { first_name_previously_changed? && last_name_previously_changed? && invited? && invitation_unconfirmed? } do
    accept_invitation!
  end

  def full_name = "#{first_name} #{last_name}"

  def self.invite!(email, by:)
    password = SecureRandom.base64(10)
    user = User.create!(email:, invited_by: by, password:, password_confirmation: password)
    UserMailer.with(user:, password:, inviter: by).invitation.deliver_later

    user
  end

  def invitation_unconfirmed? = invited_by.present? && invitation_accepted_at.blank?

  def invitation_confirmed? = invitation_accepted_at.present?

  def invited? = invited_by.present?

  def accept_invitation! = update!(invitation_accepted_at: Time.current)

  def admin_of?(list) = list_memberships.exists?(list:, role: List::Membership::ADMIN_ROLE)
end
