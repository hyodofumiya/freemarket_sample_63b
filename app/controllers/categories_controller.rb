class CategoriesController < ApplicationController
  before_action :set_categories ,only: [:index, :show]
  before_action :set_item, only: [:show, :destroy]
  before_action :admin_user?, only: [:edit, :update, :destroy]

  def index
    @category = Category.all
    @parent = @category.roots #大カテゴリーを代入
  end

  def show
    @category = Category.all
    @images = @item.images
    @comments = @item.comments
    @select_category = Category.find(params[:id]) #選択されたカテゴリーを取得
    @subtree_category = @select_category.subtree #選択されたカテゴリー自身も含めた子孫をすべて取得
    @items = Item.where(category_id: @subtree_category.ids).includes(:images).includes(:favorites).page(params[:page]) #Itemから@subtree_categoryに代入されたカテゴリーに属するitemをすべて取得し、25個ずつで区切る
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

  def set_categories
    @category = Category.all
  end

  def admin_user?#出品者以外は詳細ページへリダイレクト
    set_item
    redirect_to item_path(@item) unless @item.user == current_user
  end
end