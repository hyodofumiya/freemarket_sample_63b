class CategoriesController < ApplicationController
  def index
    @category = Category.all
    @parent = @category.roots
  end

  def show
    @category = Category.all
    @select_category = Category.find(params[:id])
    @subtree_category = @select_category.subtree
    @items = Item.where(category_id: @subtree_category.ids).page(params[:page])
    @images = Image.where(item_id: @items.ids)
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
