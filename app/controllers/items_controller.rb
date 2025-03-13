class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params.expect(:id))
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params.expect(:id))
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to @item, notice: "Item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @item = Item.find(params.expect(:id))
    if @item.update(item_params)
      redirect_to @item, notice: "Item was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item = Item.find(params.expect(:id))
    @item.destroy!
    redirect_to items_path, notice: "Item was successfully destroyed.", status: :see_other
  end

  private

  def item_params
    params.expect(item: [:title, :description, :status])
  end
end
