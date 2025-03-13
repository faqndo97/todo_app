class Item < ApplicationRecord
  validates :title, presence: true

  normalizes :title, with: ->(title) { title.strip }

  enum :status, %w[pending complete].index_by(&:itself), default: :pending, suffix: true, validate: true
end
