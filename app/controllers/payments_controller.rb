class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_item, only: [:index, :create]

  def index
    @payment = PaymentAddress.new
  end

  def create
    @payment = PaymentAddress.new(payment_params)
    if @payment.valid?
      pay
      @payment.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def payment_params
    params.require(:payment_address).permit(:postal_code, :prefecture, :city, :house_number, :building_name, :phone_number, :token)
          .merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def pay
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: payment_params[:token],
      currency: 'jpy'
    )
    # redirect_to action: :done
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end



