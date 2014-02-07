class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
#    raise request.env["omniauth.auth"].to_yaml
    @user = User.find_for_omniauth(request.env["omniauth.auth"],current_user)
    if @user.persisted?
      session["devise.authprovider"] = "omniauth"
      flash.notice = "Signed in!"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_url
    end
  end
  alias_method :facebook, :all
  alias_method :google_oauth2, :all
  
end