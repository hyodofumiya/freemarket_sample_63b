class FavoritesController < ApplicationController
  before_action :must_logined
  before_action :set_item
  def create
    Favorite.create(user_id: current_user.id, item_id: params[:item_id])
  end

  def destroy
    Favorite.find_by(user_id: current_user.id, item_id: params[:item_id]).destroy
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end
end
