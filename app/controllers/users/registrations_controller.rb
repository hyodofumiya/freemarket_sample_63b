# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    build_resource
    respond_with resource
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    unless resource.valid?
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    session["devise.regist_data"][:user]["password_confirmation"] = params[:user][:password_confirmation]
    @address = @user.shopping_addresses.build
    render template: "shopping_addresses/new"
  end
  
  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = ShoppingAddress.new(address_params)
    configure_address_names
    unless @address.valid?
      render template: "shopping_addresses/new" and return
    end
    @user.shopping_addresses.build(@address.attributes)
    @user.save
    sign_in(:user, @user)
    redirect_to root_path
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected
  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :family_name, :first_name, :family_name_kana, :first_name_kana, :birthday_year, :birthday_month, :birthday_day, :phone_number])
  end

  def address_params
    params.require(:shopping_address).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :phone_number, :post_cord, :prefecture, :cities, :address, :building_name)
  end

  def configure_address_names
    @address.family_name = @user.family_name
    @address.first_name = @user.first_name
    @address.family_name_kana = @user.family_name_kana
    @address.first_name_kana = @user.first_name_kana
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
