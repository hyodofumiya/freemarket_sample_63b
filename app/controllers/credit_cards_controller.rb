class CreditCardsController < ApplicationController
  
  require 'payjp'
  before_action :set_card

  def index
  end

  def show
  end

  def new
    card = CreditCard.where(user_id: current_user.id).first
    redirect_to action: "index" if card.present?
  end

  def create
    Payjp.api_key = 'sk_test_496e60aafad5d32afacf318d'

    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        description: 'test', #PAY.JPの顧客情報に表示する概要。
        #email: current_user.email,
        card: params['payjp-token'], # 直前のnewアクションで発行され、送られてくるトークンをここで顧客に紐付けてpayjpに永久保存します。
        metadata: {user_id: current_user.id} # 無くてもOK。
      )
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "index"
      else
        redirect_to action: "create"
      end
    end
  end

  def purchase
    Payjp.api_key = "sk_test_496e60aafad5d32afacf318d"
    Payjp::Charge.create(
      amount: 809, # 決済する値段
      card: params['payjp-token'], # フォームを送信すると作成・送信されてくるトークン
      currency: 'jpy'
    )
  end

  private

  def set_card
    @card = CreditCard.where(user_id: current_user.id).first if CreditCard.where(user_id: current_user.id).present?
  end
end
