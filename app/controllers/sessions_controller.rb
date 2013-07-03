class SessionsController < ApplicationController

  def new
#    redirect_to '/auth/google_oauth2'
  end


  def create
    auth = request.env["omniauth.auth"]
    @authentication = Authentication.find_with_omniauth(auth)
    if @authentication.nil?
      # If no authentication was found, create a brand new one here
      @authentication = Authentication.create_with_omniauth(auth)
    end

#    user = User.where(:provider => auth['provider'], 
#                      :uid => auth['uid'].to_s).first || User.find_by_email(auth["info"]["email"]) || User.create_with_omniauth(auth)


    if user_signed_in?
          if @authentication.user == current_user
            # User is signed in so they are trying to link an authentication with their
            # account. But we found the authentication and the user associated with it 
            # is the current user. So the authentication is already associated with 
            # this user. So let's display an error message.
            redirect_to root_path, :notice => "You have already linked this account"
          else
            # The authentication is not associated with the current_user so lets 
            # associate the authentication
            @authentication.user = current_user
            @authentication.save
            redirect_to root_path, :notice => "Account successfully authenticated"
          end
        else # no user is signed_in
          if @authentication.user.present?
            # The authentication we found had a user associated with it so let's 
            # just log them in here
            self.current_user = @authentication.user
            redirect_to root_path, :notice => "Signed in as #{current_user.email}!"
          else
            # The authentication has no user assigned and there is no user signed in
            # Our decision here is to create a new account for the user
            # But your app may do something different (eg. ask the user
            # if he already signed up with some other service)
            if @authentication.provider == 'identity'

              u = User.find(@authentication.uid)
              User.special_initialize(u)
              # If the provider is identity, then it means we already created a user
              # So we just load it up
            else
              # otherwise we have to create a user with the auth hash
              u = User.create_with_omniauth(auth)
              # NOTE: we will handle the different types of data we get back
              # from providers at the model level in create_with_omniauth
            end
            # We can now link the authentication with the user and log him in
            u.authentications << @authentication
            reset_session
            if !u.activation_code.blank?
              UserMailer.create_user_email(u).deliver
              redirect_to root_path, :notice => 'User was successfully created. You will not be able to sign in until you click the link in your confirmation email. Check your email for a confirmation link.'
            else
              self.current_user = u
              redirect_to root_path, :notice => "Signed in as #{u.email}!"
            end
          end
        end


        # Reset the session after successful login, per
        # 2.8 Session Fixation – Countermeasures:
        # http://guides.rubyonrails.org/security.html#session-fixation-countermeasures
#        reset_session
#        self.current_user = u

  end

  def destroy
    reset_session
    self.current_user = nil
    redirect_to root_path, :alert => "Signed out!"
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
