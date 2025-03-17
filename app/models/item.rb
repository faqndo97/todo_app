class Item < ApplicationRecord
  include ActionView::RecordIdentifier

  enum :status, %w[pending complete].index_by(&:itself), default: :pending, suffix: true, validate: true

  belongs_to :list
  belongs_to :user

  validates :title, presence: true

  normalizes :title, with: ->(title) { title.strip }

  after_create_commit do
    broadcast_replace_to(dom_id(user), target: dom_id(list), partial: "lists/list", locals: {list:})
    broadcast_append_to(dom_id(user), target: "items-pending", partial: "items/item")
  end

  after_update_commit if: :title_or_description_previously_changed? do
    broadcast_replace_to(dom_id(user), target: dom_id(self), partial: "items/item")
  end

  after_update_commit if: :status_previously_changed? do
    # Update items lists
    broadcast_remove_to(dom_id(user), target: dom_id(self))
    send(complete_status? ? "broadcast_prepend_to" : "broadcast_append_to", dom_id(user), target: "items-#{status}", partial: "items/item")

    # Update show pages
    broadcast_replace_to(dom_id(user), target: dom_id(self, :status_form_show), partial: "items/status_form", locals: {checkbox_classes: "w-[var(--text-3xl)] h-[var(--text-3xl)]"})

    # Update list
    broadcast_replace_to(dom_id(user), target: dom_id(list), partial: "lists/list", locals: {list:})
  end

  private

  def title_or_description_previously_changed?
    title_previously_changed? ||
      (description_previously_changed? &&
        ((description_previously_was.nil? || description_previously_was.empty?) ||
        (description.nil? || description.empty? && description_previously_was.present?)))
  end
end
