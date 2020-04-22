class OrdersController < ApplicationController
  before_action :must_logined, only: [:new, :create]
  before_action :set_item, only: [:new, :create]
  before_action :set_card, only: [:new, :create]
  before_action :set_shopping_address, only: [:new, :create]
  before_action :set_user, only: [:index]

  def index
    @items = Item.where(orders: @user.orders)
  end

  def new
  end

  def create
    if  @item.status == false #もし購入済みの商品であれば購入処理の前にrootに遷移させる
      redirect_to root_path, notice: '選択された商品は現在販売されていません'
    else
      Payjp.api_key = Rails.application.credentials[:payjp][:payjp_secret_key]
      pay = Payjp::Charge.create(
        amount: @item.price,
        customer: @credit_card.customer_id,
        currency: 'jpy',
      ) 
      @order = Order.create(user_id: current_user.id, item_id: @item.id, credit_card_id: @credit_card.id)
      redirect_to new_item_order_path(item_id: @item.id), notice: '購入に失敗しました' unless @order.save && @item.update(status: 'false')
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_card
    @credit_card = CreditCard.where(user_id: current_user.id).first
    unless @credit_card.nil?
      Payjp.api_key = Rails.application.credentials[:payjp][:payjp_secret_key]
      customer = Payjp::Customer.retrieve(@credit_card.customer_id)
      @default_card_information = customer.cards.retrieve(@credit_card.card_id)
      @exp_month = @default_card_information.exp_month.to_s
      @exp_year = @default_card_information.exp_year.to_s.slice(2,3)
    end
  end

  def set_shopping_address
    @shopping_address = ShoppingAddress.find_by(user_id: current_user.id)
  end
    
  def set_user
      @user = User.find(params[:user_id])
  end

end
