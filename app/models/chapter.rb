# == Schema Information
#
# Table name: chapters
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  website       :string(255)
#  street        :string(255)
#  city          :string(255)
#  state         :string(255)
#  zip           :string(255)
#  email_1       :string(255)
#  email_2       :string(255)
#  email_3       :string(255)
#  helpline      :string(255)
#  phone_1       :string(255)
#  phone_2       :string(255)
#  latitude      :float
#  longitude     :float
#  ein           :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  gmaps         :boolean
#  gmaps_address :string(255)
#

class Chapter < ActiveRecord::Base
  attr_accessible :city, :ein, :email_1, :email_2, :email_3, :helpline, :latitude, :longitude, :name, :phone_1, :phone_2, :state, :street, :website, :zip
  acts_as_gmappable :lat => 'latitude', :lng => 'longitude', :process_geocoding => :geocode?,
                  :address => "address", :normalized_address => "gmaps_address",
                  :msg => "Sorry, not even Google could figure out where that is",
                  :validate => false

  geocoded_by :address

  def geocode?
    (!address.blank? && (latitude.blank? || longitude.blank?)) #|| address_changed?
  end

  def address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.street}, #{self.city}, #{self.state} United States" 
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    header.map! { |h| h.downcase }
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      chapter = find_by_id(row["id"]) || new
      chapter.attributes = row.to_hash.slice(*accessible_attributes)
      row.delete_if do |k,v|
        true unless ['name','website', 'street', 'city', 'state', 'zip', 'email_1', 'email_2', 'email_3', 'helpline', 'phone_1', 'phone_2', 'latitude', 'longitude', 'ein'].include? k
      end
      chapter.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

end

