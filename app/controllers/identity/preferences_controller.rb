class Identity::PreferencesController < ApplicationController
  def edit
    @user = Current.user
  end

  def update
    @user = Current.user

    if @user.update(user_params)
      redirect_to root_path, notice: t(".success", locale: @user.locale)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:locale)
  end
end
