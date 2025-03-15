require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "full_name" do
    user = users(:facundo_espinosa)

    assert_equal "Facundo Espinosa", user.full_name
  end
end
