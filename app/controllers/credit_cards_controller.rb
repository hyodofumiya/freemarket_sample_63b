class CreditCardsController < ApplicationController
  
  require 'payjp'
  before_action :set_card

  def index
  end

  def new
    card = CreditCard.where(user_id: current_user.id).first
    redirect_to action: "show" if card.present?
  end

  def create
    binding.pry

    require 'payjp'
    Payjp.api_key = 'sk_test_496e60aafad5d32afacf318d'
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        description: 'test', #PAY.JPの顧客情報に表示する概要。
        card: params['payjp-token'], # 直前のnewアクションで発行され、送られてくるトークンをここで顧客に紐付けてpayjpに永久保存します。
        metadata: {user_id: current_user.id} # 無くてもOK。
      )
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "create"
      end
    end
  end

  def show
    card = CreditCard.where(user_id: current_user.id).first
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = 'sk_test_496e60aafad5d32afacf318d'
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def delete #PayjpとCardデータベースを削除します
    card = CreditCard.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = 'sk_test_496e60aafad5d32afacf318d'
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to user_path(current_user.id)
  end



  private

  def set_card
    @card = CreditCard.where(user_id: current_user.id).first if CreditCard.where(user_id: current_user.id).present?
  end
end