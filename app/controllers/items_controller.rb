class ItemsController < ApplicationController
  def index
    @list = Current.user.lists.find(params.expect(:list_id))
    @items = @list.items.in_order_of(:status, Item.statuses.values).group_by(&:status)
  end

  def show
    @item = Current.user.lists.find(params.expect(:list_id)).items.find(params.expect(:id))
  end

  def new
    @list = Current.user.lists.find(params.expect(:list_id))
    @item = @list.items.build
  end

  def edit
    @item = Current.user.lists.find(params.expect(:list_id)).items.find(params.expect(:id))
  end

  def create
    @list = Current.user.lists.find(params.expect(:list_id))
    @item = Current.user.items.build(**item_params, list: @list)

    if @item.save
      redirect_to list_item_path(@list, @item), notice: t(".success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @list = Current.user.lists.find(params.expect(:list_id))
    @item = @list.items.find_by(id: params.expect(:id))

    redirect_to list_items_path(@list), notice: t(".item_removed"), status: :see_other if @item.nil?

    @item.update(item_params)

    if request.put?
      redirect_to list_item_path(@item.list, @item), notice: t(".success"), status: :see_other
    end
  end

  def destroy
    @item = Current.user.lists.find(params.expect(:list_id)).items.find(params.expect(:id))
    @item.destroy!

    redirect_to list_items_path(@item.list), notice: t(".success"), status: :see_other
  end

  private

  def item_params
    params.expect(item: [:title, :description, :status])
  end
end
