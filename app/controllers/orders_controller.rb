class OrdersController < ApplicationController
  def index
  end

  def new
    @price = 1300
    @credit_card
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
    require 'payjp'
    Payjp.api_key = "sk_test_496e60aafad5d32afacf318d"
    Payjp::Charge.create(
      amount: 809, # 決済する値段
      card: params['payjp-token'], # フォームを送信すると作成・送信されてくるトークン
      currency: 'jpy'
    )
  end

end
