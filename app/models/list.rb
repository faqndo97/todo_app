class List < ApplicationRecord
  extend ActionView::RecordIdentifier

  belongs_to :user
  has_many :items, -> { order(position: :asc) }, dependent: :destroy
  has_many :memberships, class_name: List::Membership.name, dependent: :destroy

  validates :name, presence: true

  after_create :create_admin_membership

  normalizes :name, with: ->(name) { name.strip }

  broadcasts_to ->(list) { dom_id(list.user) }, partial: "lists/list"

  def invite(email, by: user)
    List::Invitation.new(list: self, email:, inviter: by).create
  end

  def remove(membership)
    errors.add(:base, I18n.translate("list.not_a_participant")) unless membership.list == self
    errors.add(:base, I18n.translate("list.cannot_remove_admin")) if membership.admin_role?

    return false unless errors.empty?

    membership.destroy!

    membership
  end

  private

  def create_admin_membership
    List::Membership.create!(list: self, user:, role: List::Membership::ADMIN_ROLE)
  end
end
