require "test_helper"

class Identity::EmailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in_as(users(:facundo_espinosa))
  end

  test "should get edit" do
    get edit_identity_email_url
    assert_response :success
  end

  test "should update email" do
    patch identity_email_url, params: {email: "new_email@hey.com", password_challenge: "Secret1*3*5*"}, as: :turbo_stream

    assert_turbo_stream action: "update", target: "email_edit" do
      assert_select "h1", text: "Verify your email"
    end
  end

  test "should not update email with wrong password challenge" do
    patch identity_email_url, params: {email: "new_email@hey.com", password_challenge: "SecretWrong1*3"}, as: :turbo_stream

    assert_response :unprocessable_entity
    assert_select "li", /Current password is invalid/
  end
end
