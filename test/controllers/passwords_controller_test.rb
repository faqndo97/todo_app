require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in_as(users(:facundo_espinosa))
  end

  test "should get edit" do
    get edit_password_url
    assert_response :success
  end

  test "should update password" do
    patch password_url, params: {password_challenge: "Secret1*3*5*", password: "Secret6*4*2*", password_confirmation: "Secret6*4*2*"}, as: :turbo_stream

    assert_turbo_stream action: "update", target: "password_edit" do
      assert_select "h1", text: "Change your password"
    end
  end

  test "should not update password with wrong password challenge" do
    patch password_url, params: {password_challenge: "SecretWrong1*3", password: "Secret6*4*2*", password_confirmation: "Secret6*4*2*"}, as: :turbo_stream

    assert_response :unprocessable_entity
    assert_select "li", /Current password is invalid/
  end
end
