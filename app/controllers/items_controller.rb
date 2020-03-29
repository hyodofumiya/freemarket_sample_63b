class ItemsController < ApplicationController
  before_action :set_item, only: [:show]
  before_action :admin_user?, only: [:edit, :update, :destroy]

  def index
  end

  def show
    @images = @item.images
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def admin_user?
    set_item
    redirect_to item_path(@item) unless @item.user == current_user
  end
end
