class CategoriesController < ApplicationController
  def index
    @category = Category.all
    @parent = @category.roots
  end

  def show
    @category = Category.all
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
