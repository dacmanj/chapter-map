class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?
  helper_method :admin_only
  helper_method :admin_user?

  private
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue Exception => e
        nil
      end
    end

    def user_signed_in?
      return true if current_user
    end

    def correct_user?
      @user = User.find(params[:id])
      unless current_user == @user || current_user.admin?
        redirect_to root_url, :alert => "Access denied."
      end
    end

    def admin_user?
      begin
        current_user.admin? || current_user.email == 'dmanuel@pflag.org'
      rescue Exception => e
        nil
      end
    end

    def admin_only
      unless !current_user.nil? && current_user.admin?
        redirect_to root_url, :alert => "Access denied."
      end
    end

    def authenticate_user!
      if !current_user
        redirect_to root_url, :alert => 'You need to sign in for access to this page.'
      end
    end

end
