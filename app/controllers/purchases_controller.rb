class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :purchase_item
  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  def purchase_params
    params.require(:purchase_address).permit(:post_code, :prefecture_id, :city, :house_num, :building, :phone_num).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def purchase_item
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user_id || @item.purchase.present?
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end
