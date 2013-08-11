class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?
  helper_method :chapter_leader?
  helper_method :admin_only
  helper_method :admin_user?
  after_filter :flash_to_headers


  private
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue Exception => e
        nil
      end
    end

    def current_user=(user)
      @current_user = user
      session[:user_id] = user.nil? ? user : user.id
    end

    def user_signed_in?
      return true if current_user
    end

    def correct_user?
        @user = User.find(params[:id])
        unless current_user == @user || admin_user?
          redirect_to root_url, :alert => "Access denied."
        end
    end

    def chapter_leader?
      id = params[:id]
      if !id.blank? && id != "import" 
        @chapter = Chapter.find(params[:id])
        unless @chapter.users.include?(current_user) || admin_user?
          redirect_to root_url, :alert => "Access denied."
        end
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
      unless !current_user.blank? && current_user.admin?
        redirect_to root_url, :alert => "Access denied."
      end
    end

    def authenticate_user!
      if !current_user
        redirect_to new_session_path, :alert => 'You need to sign in for access to this page.'
      elsif !current_user.activation_code.blank?
        redirect_to root_url, :alert => 'You must confirm your email address before signing in. Check your email for your activation link.'       
      end
    end

    def flash_to_headers
      return unless request.xhr?
      response.headers['X-Message'] = flash_message
      response.headers["X-Message-Type"] = flash_type.to_s
 
      flash.discard # don't want the flash to appear when you reload page
    end
 
    def flash_message
      [:error, :warning, :notice].each do |type|
        return flash[type] unless flash[type].blank?
      end
      return "test"
    end
 
    def flash_type
      [:error, :warning, :notice].each do |type|
        return type unless flash[type].blank?
      end
      return nil
    end
 

end
