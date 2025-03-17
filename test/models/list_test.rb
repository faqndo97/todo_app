require "test_helper"

class ListTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  test "name normalization" do
    list = List.new(name: "  AwesoMe List  ", user: users(:facundo_espinosa))

    list.save!

    assert_equal "AwesoMe List", list.name
  end

  test "broadcast list append after create" do
    user = users(:facundo_espinosa)
    list = List.new(name: "Groceries", user:)

    perform_enqueued_jobs do
      turbo_streams = capture_turbo_stream_broadcasts dom_id(user) do
        list.save!
      end

      assert_equal "append", turbo_streams.first[:action]
      assert_equal "lists", turbo_streams.first[:target]
    end
  end

  test "broadcast list update after create" do
    list = lists(:work)
    user = users(:facundo_espinosa)

    perform_enqueued_jobs do
      turbo_streams = capture_turbo_stream_broadcasts dom_id(user) do
        list.save!
      end

      assert_equal "replace", turbo_streams.first[:action]
      assert_equal "list_#{list.id}", turbo_streams.first[:target]
    end
  end

  test "broadcast list destroy after destroy" do
    list = lists(:work)
    user = users(:facundo_espinosa)

    perform_enqueued_jobs do
      turbo_streams = capture_turbo_stream_broadcasts dom_id(user) do
        list.destroy!
      end

      assert_equal "remove", turbo_streams.first[:action]
      assert_equal "list_#{list.id}", turbo_streams.first[:target]
    end
  end
end
