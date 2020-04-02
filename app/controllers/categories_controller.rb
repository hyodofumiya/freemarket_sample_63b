class CategoriesController < ApplicationController
before_action :set_category ,only: [:index, :show]

  def index
    @parent = @category.roots #大カテゴリーを代入
  end

  def show
    @select_category = Category.find(params[:id]) #選択されたカテゴリーを取得
    @subtree_category = @select_category.subtree #選択されたカテゴリー自身も含めた子孫をすべて取得
    @items = Item.where(category_id: @subtree_category.ids).page(params[:page]) #Itemから@subtree_categoryに代入されたカテゴリーに属するitemをすべて取得し、25個ずつで区切る
    @images = Image.where(item_id: @items.ids) #選択されたitemの画像を取得
  end

  def new
  end

  def creat
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_category
    @category = Category.all
  end
end


