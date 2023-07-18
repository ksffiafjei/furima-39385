class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_item, only: [:index, :create]

  def index
    @purchase_address = PurchaseAddress.new
    return unless current_user == @item.user || @item.purchase.present?

    redirect_to root_path
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: purchase_params[:token],
        currency: 'jpy'
      )
      @purchase_address.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(:postalcode, :prefecture_id, :city, :streetaddress, :buildingname, :phonenumber).merge(
      item_id: params[:item_id], token: params[:token], user_id: current_user.id
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
