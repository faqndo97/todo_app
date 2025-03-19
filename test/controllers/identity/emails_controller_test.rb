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

    assert_turbo_stream action: "append", target: "toast_container" do
      assert_select "div[data-toast-text-value='Your email has been changed']"
    end
    assert_turbo_stream action: "reset_form", target: "email_form"
  end

  test "should not update email with wrong password challenge" do
    patch identity_email_url, params: {email: "new_email@hey.com", password_challenge: "SecretWrong1*3"}, as: :turbo_stream

    assert_response :unprocessable_entity
    assert_select "li", /Current password is invalid/
  end
end
