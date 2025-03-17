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

    redirect_to lists_path
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

    redirect_to list_items_path(Current.user.lists.first)
  end

  private

  def list_params
    params.require(:list).permit(:name, :description)
  end
end
