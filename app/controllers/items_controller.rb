class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    Item.create(item_params)
    redirect_to root_path
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
