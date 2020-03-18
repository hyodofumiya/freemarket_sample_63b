class UsersController < ApplicationController
  before_action :set_current_user, only: [:edit, :show]
  before_action :must_logined, only: [:edit, :show]
  def show
  end

  def edit
  end

  private

  def set_current_user
    @user = current_user
  end

  def must_logined
    redirect_to user_session_path unless user_signed_in?
  end
end
