require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = items(:with_description_pending)
    @user = users(:facundo_espinosa)
    sign_in_as(@user)
  end

  test "should get index" do
    get list_items_url(@item.list)
    assert_response :success
  end

  test "should get new" do
    get new_list_item_url(@item.list)
    assert_response :success
  end

  test "should create item" do
    assert_difference("Item.count") do
      post list_items_url(@item.list), params: {item: {description: @item.description, status: @item.status, title: @item.title}}
    end

    assert_redirected_to list_items_url(@item.list)
  end

  test "should show item" do
    get list_item_url(@item.list, @item)
    assert_response :success
  end

  test "should get edit" do
    get edit_list_item_url(@item.list, @item)
    assert_response :success
  end

  test "should update item" do
    put list_item_url(@item.list, @item), params: {item: {description: @item.description, status: @item.status, title: @item.title}}
    assert_redirected_to list_item_url(@item.list, @item)
  end

  test "should destroy item" do
    assert_difference("Item.count", -1) do
      delete list_item_url(@item.list, @item)
    end

    assert_redirected_to list_items_url(@item.list)
  end
end
