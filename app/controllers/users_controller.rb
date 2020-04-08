class UsersController < ApplicationController
  before_action :must_logined, only: [:edit]
  before_action :set_user, only: [:show, :profile_photo, :edit, :profile_photo_update]
  before_action :set_current_user, only: [:edit, :show]
  before_action :must_logined, only: [:edit, :show]
  def show
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      @user = current_user
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :family_name, :first_name, :family_name_kana, :first_name_kana, :email, :birthday_year, :birthday_month, :birthday_day, :phone_number)
  end

  def set_current_user
    @user = current_user
  end
  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      @user = current_user
      render :edit
    end
  end

  def profile_photo_update
    unless @user.id == current_user.id
      redirect_to user_path(@user)
    end
    @user.update(user_photo_params)
    redirect_to user_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :family_name, :first_name, :family_name_kana, :first_name_kana, :email, :birthday_year, :birthday_month, :birthday_day, :phone_number)
  end

  def user_photo_params
    params.require(:user).permit(:photo_filepath)
  end

  def set_current_user
    @user = current_user
  end

  def set_user
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = User.find(params[:id])
    end
  end
end
