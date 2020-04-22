class ShoppingAddressesController < ApplicationController
  before_action :must_logined
  before_action :current_user?
  def edit
    @address = ShoppingAddress.find(params[:id])
  end

  def update
    @address = ShoppingAddress.find(params[:id])
    if @address.update(address_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private
  
  def address_params
    params.require(:shopping_address).permit(:post_cord, :prefecture, :cities, :address, :building_name)
  end
  
end
