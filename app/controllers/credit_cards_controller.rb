class CreditCardsController < ApplicationController
  
  require 'payjp'
  before_action :set_card
  def index
  end

  def new
    @category = Category.all
    redirect_to action: "show", id: @card.id if @card.present?
    @item = params[:item_id] if params[:item_id].present?
  end

  def create
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
      @item = params[:item_id] if params[:item_id].present?
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to user_credit_card_path(user_id:current_user.id, id:@card.id, item_id: @item.to_i)
      else
        redirect_to action: "create"
      end
    end
  end

  def show
    @item = params[:item_id].to_i if present?
    @category = Category.all
    @card = CreditCard.where(user_id: current_user.id).first
    if @card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = 'sk_test_496e60aafad5d32afacf318d'
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
      @exp_month = @default_card_information.exp_month.to_s
      @exp_year = @default_card_information.exp_year.to_s.slice(2,3)
    end
  end

  def destroy #PayjpとCardデータベースを削除します
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
    if user_signed_in?
      @card = CreditCard.where(user_id: current_user.id).first if CreditCard.where(user_id: current_user.id).present?
    else
    redirect_to new_user_session_path unless user_signed_in?
    end
  end
end