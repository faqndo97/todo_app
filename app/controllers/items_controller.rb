class ItemsController < ApplicationController
  def index
    @items = Current.user.items
  end

  def show
    @item = Current.user.items.find(params.expect(:id))
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Current.user.items.find(params.expect(:id))
  end

  def create
    @item = Current.user.items.build(item_params)

    if @item.save
      # redirect_to @item, notice: "Item was successfully created."
      redirect_to @item, notice: t(".success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @item = Current.user.items.find(params.expect(:id))

    if @item.update(item_params)
      # redirect_to @item, notice: "Item was successfully updated.", status: :see_other
      redirect_to @item, notice: t(".success"), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item = Current.user.items.find(params.expect(:id))
    @item.destroy!

    # redirect_to items_path, notice: "Item was successfully destroyed.", status: :see_other
    redirect_to items_path, notice: t(".success"), status: :see_other
  end

  private

  def item_params
    params.expect(item: [:title, :description, :status])
  end
end
