class FavoritesController < ApplicationController
  before_action :must_logined
  before_action :set_item, only: [:create, :destroy]
  before_action :set_user, only: [:index]

  def index
    @items = Item.where(favorites: @user.favorites)
  end

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
    
  def set_user
      @user = User.find(params[:user_id])
  end
end
