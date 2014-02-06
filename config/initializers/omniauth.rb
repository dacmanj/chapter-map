Rails.application.config.middleware.use OmniAuth::Builder do
#  provider :google_oauth2, ENV['OMNIAUTH_PROVIDER_KEY'], ENV['OMNIAUTH_PROVIDER_SECRET']
#  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
#  provider :identity, fields: [:email, :name], model: User, on_failed_registration: lambda { |env|
#		UsersController.action(:new).call(env)
#	}
end
