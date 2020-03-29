class FavoritesController < ApplicationController
  before_action :must_logined
  
  def create
      Favorite.create(user_id: current_user.id, item_id: params[:item_id])
    end

  end

  def destroy
    Favorite.find(params[:id]).destroy
  end
end
