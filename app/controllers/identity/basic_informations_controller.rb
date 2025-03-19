class Identity::BasicInformationsController < ApplicationController
  def edit
    @user = Current.user
  end

  def update
    @user = Current.user

    if @user.update(user_params)
      render turbo_stream: [
        turbo_stream.append("toast_container", partial: "shared/toast", locals: {variant: :success, text: t(".success")}),
        turbo_stream.replace("basic_information_form", partial: "identity/basic_informations/form", locals: {user: @user})
      ]
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
