require "test_helper"

class ItemTest < ActiveSupport::TestCase
  test "title normalization" do
    item = Item.new(title: "  AwesoMe Test  ", user: users(:facundo_espinosa))

    item.save!

    assert_equal "AwesoMe Test", item.title
  end
end
