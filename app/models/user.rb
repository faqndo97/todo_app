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

  has_many :sessions, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :items, dependent: :destroy

  validates :first_name, :last_name, presence: true
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

  def full_name = "#{first_name} #{last_name}"
end
