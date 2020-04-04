class CreditCardsController < ApplicationController
  require "payjp"
  
  before_action :set_card

  def index
  end

  def new
    card = Credit_cards.where(user_id: current_user.id)
  end

  def create
    Payjp.api_key = 'sk_test_496e60aafad5d32afacf318d'

    if params['payjo-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        description: 'test',
        email: current_user.email,
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
      )
      @card = Credit_card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "index"
      else
        redirect_to action: "create"
      end
    end
  end

  private

  def set_card
    @card = Credit_card.where(user_id: current_user.id).first if Credit_card.where(user_id: current_user.id).present?
  end

end

