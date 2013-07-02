class UserMailer < ActionMailer::Base
  default from: "info@pflag.org"


  def create_user_email(user)
    @user = user
    @url  = new_session_path(:only_path => false)
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

end
