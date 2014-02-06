class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :admin_user?
  after_filter :flash_to_headers

  def after_sign_in_path_for(resource)
    redirect_path = chapters_path
  end

  private

    def admin_user?
      current_user.admin? unless current_user.blank?
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
