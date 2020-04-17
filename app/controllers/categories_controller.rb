class CategoriesController < ApplicationController

  def index
    @parent = @category.roots
  end

  def show
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
  end

end