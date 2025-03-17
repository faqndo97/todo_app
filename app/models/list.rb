class List < ApplicationRecord
  extend ActionView::RecordIdentifier

  belongs_to :user
  has_many :items, -> { order(position: :asc) }, dependent: :destroy

  validates :name, presence: true

  normalizes :name, with: ->(name) { name.strip }

  broadcasts_to ->(list) { dom_id(list.user) }, partial: "lists/list"
end
