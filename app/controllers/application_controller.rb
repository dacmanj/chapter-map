class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :admin_user?
  after_filter :flash_to_headers

  def after_sign_in_path_for(resource)
    redirect_path = chapters_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  private

    def admin_user?
      current_user.admin? unless current_user.blank?
    end

    def flash_to_headers
#      return unless request.xhr?
      msg = flash_message
      response.headers['X-Message'] = msg
      response.headers["X-Message-Type"] = flash_type.to_s
      flash.discard # don't want the flash to appear when you reload page
    end
 
    def flash_message
      [:error, :warning, :notice].each do |type|
        return flash[type] unless flash[type].blank?
      end
      # if we don't return something here, the above code will return "error, warning, notice"
      return ''
    end

    def flash_type
      #:keep will instruct the js to not update or remove the shown message.
      #just write flash[:keep] = true (or any other value) in your controller code
      [:error, :warning, :notice, :keep].each do |type|
        return type unless flash[type].blank?
      end
      #don't return the array from above which would happen if we don't have an explicit return statement
      #returning :empty will also allow you to easily know that no flash message was transmitted
      return :empty
    end
end
