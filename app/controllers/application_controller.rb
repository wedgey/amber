class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end


    def logged_in?
      !current_user.nil?
    end

    def get_wunderground_key
      ENV['WUNDERGROUND_API_KEY']
    end

    def get_ggmap_key
      ENV['GGMAP_APP_KEY']
    end

    helper_method :current_user, :logged_in?, :get_wunderground_key, :get_ggmap_key
end
