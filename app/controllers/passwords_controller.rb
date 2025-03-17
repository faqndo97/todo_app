class PasswordsController < ApplicationController
  before_action :set_user

  def edit
  end

  def update
    unless @user.update(user_params)
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
