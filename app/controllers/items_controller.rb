class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all.order(created_at: :desc)
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

  def show
    @user = @item.user
  end

  def edit
    if current_user == @item.user
    else
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    if user_signed_in? && current_user == @item.user
      @item.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :productname, :description, :price, :category_id, :status_id,
                                 :shippingcostresponsibility_id, :prefecture_id, :deliveryday_id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
