class Chapter < ActiveRecord::Base
  attr_accessible :city, :ein, :email_1, :email_2, :email_3, :helpline, :latitude, :longitude, :name, :phone_1, :phone_2, :state, :street, :website, :zip
  acts_as_gmappable :lat => 'latitude', :lng => 'longitude', :process_geocoding => :geocode?,
                  :address => "address", :normalized_address => "address",
                  :msg => "Sorry, not even Google could figure out where that is"

end

def geocode?
  (!address.blank? && (latitude.blank? || longitude.blank?)) #|| address_changed?
end

def address
#describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
  "#{self.street}, #{self.city}, #{self.state} United States" 
end