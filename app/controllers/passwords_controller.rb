class PasswordsController < ApplicationController
  before_action :set_user

  def edit
  end

  def update
    if @user.update(user_params)
      render turbo_stream: [
        turbo_stream.append("toast_container", partial: "shared/toast", locals: {variant: :success, text: t(".success")}),
        turbo_stream.reset_form("password_form")
      ]
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = Current.user
  end

  def user_params
    params.permit(:password, :password_confirmation, :password_challenge).with_defaults(password_challenge: "")
  end
end
