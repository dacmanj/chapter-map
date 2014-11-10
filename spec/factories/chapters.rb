FactoryGirl.define do
  factory :chapter do
	  name "PFLAG DC"
	  website "www.pflagdc.org"
	  street "1701 14th St. NW"
	  city "Washington"
	  state "DC"
	  zip "20009"
	  email_1 "info@pflagdc.org"
	  phone_1 "202-638-3852"
	  ein 521348642
	  separate_exemption false
	  database_identifier "CDC01"
	  twitter_url "https://twitter.com/pflagdc"
	  facebook_url "https://www.facebook.com/MetroDCPFLAG"
  end

end
