FactoryGirl.define do
	factory :user do
		name "Some User"
		email "user@pflag.org"
		password "t1234567"
		password_confirmation "t1234567"
	end
end
