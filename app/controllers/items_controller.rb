class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]
  before_action :admin_user?, only: [:edit, :update, :destroy]

  def index
  end

  def show
    @images = @item.images
    @comments = @item.comments
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
    if @item.destroy
      redirect_to root_path
    else
      @images = @item.images
      redirect_to item_path(@item)
    end
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def admin_user?#出品者以外は詳細ページへリダイレクト
    set_item
    redirect_to item_path(@item) unless @item.user == current_user
  end
end
