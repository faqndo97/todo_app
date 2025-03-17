class UserMailer < ApplicationMailer
  def password_reset
    @user = params[:user]
    @signed_id = @user.generate_token_for(:password_reset)

    I18n.with_locale(@user.locale) do
      mail to: @user.email
    end
  end

  def email_verification
    @user = params[:user]
    @signed_id = @user.generate_token_for(:email_verification)

    I18n.with_locale(@user.locale) do
      mail to: @user.email
    end
  end
end
