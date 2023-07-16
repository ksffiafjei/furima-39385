class PurchasesController < ApplicationController
  def index
    @purchase_address = PurchaseAddress.new
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id].to_i)
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      Payjp.api_key = "sk_test_fa18e5d61127486391588f17"
        Payjp::Charge.create(
          amount: @item.price,
          card: purchase_params[:token],
          currency: 'jpy'
        )
        binding.pry
      @purchase_address.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(:user_id, :item_id, :postalcode, :prefecture_id, :city, :streetaddress, :buildingname, :phonenumber).merge(item_id: params[:item_id], token: params[:token], user_id: current_user.id)
  end
end