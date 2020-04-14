class OrdersController < ApplicationController
  require 'payjp'
  before_action :set_categories, only: [:new, :create]
  before_action :set_item, only: [:new, :create]
  before_action :set_card, only: [:new, :create]
  before_action :set_shopping_address, only: [:new, :create]

  def index
  end

  def new
  end

  def create
    binding.pry
    if  @item.status == false #もし購入済みの商品であれば購入処理の前にrootに遷移させる
      redirect_to root_path, notice: '選択された商品は現在販売されていません'
    else
      Payjp.api_key = 'sk_test_496e60aafad5d32afacf318d'
      pay = Payjp::Charge.create(
        :amount => @item.price,
        :customer => @credit_card.customer_id,
        :currency => 'jpy',
      ) 
      @order = Order.create(user_id: current_user.id, item_id: @item.id, credit_card_id: @credit_card.id)
      @item.update(status: 'false')
      if @order.save && @item.save
      else
        redirect_to action: "new", notice: '購入に失敗しました'
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_categories
    @category = Category.all
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_card
    @credit_card = CreditCard.where(user_id: current_user.id).first
    unless @credit_card.nil?
      Payjp.api_key = 'sk_test_496e60aafad5d32afacf318d'
      customer = Payjp::Customer.retrieve(@credit_card.customer_id)
      @default_card_information = customer.cards.retrieve(@credit_card.card_id)
      @exp_month = @default_card_information.exp_month.to_s
      @exp_year = @default_card_information.exp_year.to_s.slice(2,3)
    end
  end

  def set_shopping_address
    @shopping_address = ShoppingAddress.find_by(user_id: current_user.id)
  end

end
