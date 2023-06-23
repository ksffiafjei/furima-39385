class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params.merge(user_id: current_user.id))
    if @item.save
      redirect_to root_path
    else
      flash.now[:alert] = @item.errors.full_messages.join(', ')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :productname, :description, :price, :category_id, :status_id,
                                 :shippingcostresponsibility_id, :prefecture_id, :deliveryday_id)
  end
end
