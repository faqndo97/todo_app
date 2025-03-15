class Item < ApplicationRecord
  enum :status, %w[pending complete].index_by(&:itself), default: :pending, suffix: true, validate: true

  belongs_to :user

  validates :title, presence: true

  normalizes :title, with: ->(title) { title.strip }
end
