class CategoriesController < ApplicationController
  def index
    @category = Category.all
    @parent = @category.roots
  end

  def show
    @category = Category.all
    @select_category = Category.find(params[:id])
    @items = Item.where(category_id: params[:id])
    @image = Image.where(item_id: @items.ids)
    binding.pry
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
