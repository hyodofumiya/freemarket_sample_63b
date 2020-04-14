class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]
  before_action :admin_user?, only: [:edit, :update, :destroy]
  INDEX_ROW_COUNT = 5

  def index
    @items = Item.all.order(created_at: :DESC).includes(:comments, :favorites, :images)
    @category = Category.all
    @category_items = array_items_by_category
  end

  def show
    @category = Category.all
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
      flash[:notice] = "エラーが発生しました。削除できません。"
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

  def array_items_by_category
    item_array = []
    Category::DISPLAY_TOP_PAGE.each do |num|
      item_array << { id: num.to_s, items: Item.category_items(num)}
    end
    return item_array
  end
end
