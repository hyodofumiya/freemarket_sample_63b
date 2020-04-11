class OrdersController < ApplicationController
  def index
  end

  def new
    require 'payjp'
    @items = Item.find(params[:item_id])
    @credit_card = CreditCard.where(user_id: current_user.id).first
    unless @credit_card.nil?
      Payjp.api_key = 'sk_test_496e60aafad5d32afacf318d'
      customer = Payjp::Customer.retrieve(@credit_card.customer_id)
      @default_card_information = customer.cards.retrieve(@credit_card.card_id)
      @exp_month = @default_card_information.exp_month.to_s
      @exp_year = @default_card_information.exp_year.to_s.slice(2,3)
    end
    @category = Category.all
    @shopping_address = ShoppingAddress.find_by(user_id: current_user.id)
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def purchase
    Payjp.api_key = "sk_test_496e60aafad5d32afacf318d"
    Payjp::Charge.create(
      amount: 809, # 決済する値段
      card: params['payjp-token'], # フォームを送信すると作成・送信されてくるトークン
      currency: 'jpy'
    )
  end

end
