class UsersController < ApplicationController
  before_action(only: [:show, :edit]){@user = User.find(params[:id])}

  def show
  end

  def edit
  end
end
