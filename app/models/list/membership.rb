class List::Membership < ApplicationRecord
  ROLES = [
    PARTICIPANT_ROLE = "participant",
    ADMIN_ROLE = "admin"
  ].freeze

  belongs_to :list
  belongs_to :user

  enum :role, ROLES.index_by(&:itself), default: PARTICIPANT_ROLE, suffix: true, validate: true

  validates :list, uniqueness: {scope: :user}
  validates :user, uniqueness: {scope: :list}
end
