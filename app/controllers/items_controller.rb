class ItemsController < ApplicationController
  def index
    @category = Category.all
    @parent_category = @category.roots
  end

  def show
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
