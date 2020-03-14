class UsersController < ApplicationController
  def index
  end

  def edit
    @user = User.find(params[:id])
  end
end
