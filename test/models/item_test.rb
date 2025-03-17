require "test_helper"

class ItemTest < ActiveSupport::TestCase
  test "title normalization" do
    item = Item.new(title: "  AwesoMe Test  ", user: users(:facundo_espinosa), list: lists(:work))

    item.save!

    assert_equal "AwesoMe Test", item.title
  end

  test "broadcasts list update after create" do
    list = lists(:work)
    user = users(:facundo_espinosa)
    item = Item.new(title: "Buy bananas", user:, list:)

    turbo_streams = capture_turbo_stream_broadcasts dom_id(user) do
      item.save!
    end

    assert_equal "replace", turbo_streams.first[:action]
    assert_equal dom_id(list), turbo_streams.first[:target]
  end

  test "broadcasts item append after create" do
    list = lists(:groceries)
    user = users(:facundo_espinosa)
    item = Item.new(title: "Buy bananas", user:, list:)

    turbo_streams = capture_turbo_stream_broadcasts dom_id(user) do
      item.save!
    end

    assert_equal "append", turbo_streams.second[:action]
    assert_equal "items-pending", turbo_streams.second[:target]
  end

  test "broadcasts item changes after status change" do
    item = items(:without_description_pending)
    user = users(:facundo_espinosa)

    turbo_streams = capture_turbo_stream_broadcasts dom_id(user) do
      item.complete_status!
    end

    assert_equal "remove", turbo_streams.first[:action]
    assert_equal "item_#{item.id}", turbo_streams.first[:target]

    assert_equal "replace", turbo_streams.third[:action]
    assert_equal "status_form_show_item_#{item.id}", turbo_streams.third[:target]

    assert_equal "replace", turbo_streams.fourth[:action]
    assert_equal "list_#{item.list.id}", turbo_streams.fourth[:target]
  end

  test "broadcast prepend item to complete items section after status change to complete" do
    item = items(:without_description_pending)
    user = users(:facundo_espinosa)

    turbo_streams = capture_turbo_stream_broadcasts dom_id(user) do
      item.complete_status!
    end

    assert_equal "prepend", turbo_streams.second[:action]
    assert_equal "items-complete", turbo_streams.second[:target]
  end

  test "broadcast append item to pending items section after status change to pending" do
    item = items(:without_description_complete)
    user = users(:facundo_espinosa)

    turbo_streams = capture_turbo_stream_broadcasts dom_id(user) do
      item.pending_status!
    end

    assert_equal "append", turbo_streams.second[:action]
    assert_equal "items-pending", turbo_streams.second[:target]
  end

  test "broadcast item list changes after title or description change" do
    item = items(:without_description_pending)
    user = users(:facundo_espinosa)

    turbo_streams = capture_turbo_stream_broadcasts dom_id(user) do
      item.update!(title: "Buy bananas and apples")
    end

    assert_equal "replace", turbo_streams.first[:action]
    assert_equal "item_#{item.id}", turbo_streams.first[:target]
  end
end
