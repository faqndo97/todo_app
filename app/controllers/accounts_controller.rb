class AccountsController < ApplicationController
  def show
    @user = Current.user
  end

  def edit
    @user = Current.user
  end

  def update
    @user = Current.user

    @user.update!(user_params)

    redirect_to account_path, notice: t(".success"), status: :see_other
  end

  private

  def user_params
    params.require(:user).permit(:locale)
  end
end
