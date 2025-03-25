class Lists::MembershipsController < ApplicationController
  before_action :set_list
  before_action :authorize_list_admin

  def index
    @memberships = @list.memberships
  end

  def new
    @membership = @list.memberships.new
  end

  def create
    @invitation = @list.invite(membership_params[:email], by: Current.user)

    if @invitation.errors.any?
      @membership = @invitation.membership || @list.memberships.new
      render :new
    else
      render turbo_stream: [
        turbo_stream.append("memberships", partial: "lists/memberships/membership", locals: {membership: @invitation.membership, list: @list}),
        turbo_stream.append("toast_container", partial: "shared/toast", locals: {variant: :success, text: t(".success")})
      ]
    end
  end

  def destroy
    if (@membership = @list.remove(List::Membership.find(params[:id])))
      render turbo_stream: [
        turbo_stream.remove(@membership),
        turbo_stream.append("toast_container", partial: "shared/toast", locals: {variant: :success, text: t(".success")})
      ]
    else
      render turbo_stream: turbo_stream.append("toast_container", partial: "shared/toast", locals: {variant: :error, text: t(".error")})
    end
  end

  private

  def set_list
    @list = Current.user.lists.find(params[:list_id])
  end

  def authorize_list_admin
    redirect_to list_items_path(@list) unless Current.user.admin_of?(@list)
  end

  def membership_params
    params.expect(list_membership: :email)
  end
end
