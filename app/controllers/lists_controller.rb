class ListsController < ApplicationController
  def index
    @lists = Current.user.lists
  end

  def new
    @list = Current.user.lists.build
  end

  def create
    @list = Current.user.lists.build(list_params)

    @list.save

    render turbo_stream: [
      turbo_stream.redirect_to(list_items_path(@list), flash: {partial: "shared/toast", locals: {variant: :success, text: "List created successfully"}}),
      turbo_stream.update("new_list", partial: "lists/new_list_btn")
    ]
  end

  def edit
    @list = Current.user.lists.find(params[:id])
  end

  def update
    @list = Current.user.lists.find(params[:id])

    @list.update(list_params)

    redirect_to list_items_path(@list)
  end

  def destroy
    @list = Current.user.lists.find(params[:id])

    @list.destroy

    if Current.user.lists.any?
      redirect_to list_items_path(Current.user.lists.first), notice: t(".success")
    else
      redirect_to root_path, notice: t(".success")
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :description)
  end
end
