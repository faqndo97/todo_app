class Item < ApplicationRecord
  include ActionView::RecordIdentifier

  enum :status, %w[pending complete].index_by(&:itself), default: :pending, suffix: true, validate: true

  belongs_to :user

  validates :title, presence: true

  normalizes :title, with: ->(title) { title.strip }

  after_update if: :status_previously_changed? do
    # Update items lists
    broadcast_remove_to("#{user.id}-items", target: dom_id(self))
    send(complete_status? ? "broadcast_prepend_to" : "broadcast_append_to", "#{user.id}-items", target: "items-#{status}", partial: "items/item", locals: {item: self})

    # Update show pages
    broadcast_replace_to(dom_id(self, dom_id(user)), target: dom_id(self, :status_form), partial: "items/status_form", locals: {item: self, checkbox_classes: "w-[var(--text-3xl)] h-[var(--text-3xl)]"})
  end
end
