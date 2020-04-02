class CategoriesController < ApplicationController
before_action :set_category ,only: [:index, :show]

  def index
    @parent = @category.roots
  end

  def show
    @select_category = Category.find(params[:id])
    @subtree_category = @select_category.subtree
    @items = Item.where(category_id: @subtree_category.ids).page(params[:page])
    @images = Image.where(item_id: @items.ids)
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


