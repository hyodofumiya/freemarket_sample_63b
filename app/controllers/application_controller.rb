class ApplicationController < ActionController::Base
    before_action :basic_auth, if: :production?
    before_action :set_categoryall

    private

    def production?
        Rails.env.production?
    end
    
    def basic_auth
        authenticate_or_request_with_http_basic do |username, password|
            username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
        end
    end

    def must_logined
        redirect_to user_session_path unless user_signed_in?
    end

    def set_categoryall
        @category = Category.all
    end

    def current_user?
        redirect_to root unless User.find(params[:user_id]) == current_user
    end
end
