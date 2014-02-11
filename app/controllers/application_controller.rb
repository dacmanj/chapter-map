class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization :unless => :do_not_check_authorization?

  helper_method :admin_user?
  helper_method :has_role?
  after_filter :flash_to_headers

  def after_sign_in_path_for(resource)
    redirect_path = chapters_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    if signed_in?
      redirect_to chapters_path, :alert => exception.message
    else
      redirect_to new_user_session_path, :alert => exception.message
    end
  end

  private

    def do_not_check_authorization?
      respond_to?(:devise_controller?)
    end

    def has_role?(role)
      current_user.has_role(role) unless current_user.blank?
    end

    def admin_user?
      current_user.has_role? :admin unless current_user.blank?
    end


    def flash_to_headers
    # if AJAX request add messages to heaader
    return unless request.xhr?

    message = ''
    message_type = :error

    [:error, :warning, :notice, :success].each do |type|
      unless flash[type].blank?
        message = flash[type]
        message_type = type.to_s

      end
    end

    unless message.blank?
    # We need encode our message, because we can't use      
    # unicode symbols in headers
      response.headers['X-Message'] = URI::encode message
      response.headers['X-Message-Type'] = message_type
      # Clear messages
      flash.discard
    end
  end

end
