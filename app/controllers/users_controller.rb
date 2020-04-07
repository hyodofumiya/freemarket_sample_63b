class UsersController < ApplicationController
  before_action :set_current_user, only: [:edit, :show]
  before_action :must_logined, only: [:edit, :show]
  def show
    @card = Credit_card.find(user_id: current_user.id)
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
end
