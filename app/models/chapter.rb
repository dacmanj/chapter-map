# == Schema Information
#
# Table name: chapters
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
#  website               :string(255)
#  street                :string(255)
#  city                  :string(255)
#  state                 :string(255)
#  zip                   :string(255)
#  email_1               :string(255)
#  email_2               :string(255)
#  email_3               :string(255)
#  helpline              :string(255)
#  phone_1               :string(255)
#  phone_2               :string(255)
#  latitude              :float
#  longitude             :float
#  ein                   :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  gmaps                 :boolean
#  gmaps_address         :string(255)
#  radius                :integer
#  category              :string(255)
#  separate_exemption    :boolean
#  inactive              :boolean
#  database_identifier   :string(255)
#  email_1_import_id     :string(255)
#  email_2_import_id     :string(255)
#  email_3_import_id     :string(255)
#  helpline_import_id    :string(255)
#  phone_1_import_id     :string(255)
#  phone_2_import_id     :string(255)
#  address_import_id     :string(255)
#  independent_import_id :string(255)
#  ein_import_id         :string(255)
#  revoked               :boolean
#  revocation_date       :date
#

# == Schema Information
#
# Table name: chapters
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
#  website               :string(255)
#  street                :string(255)
#  city                  :string(255)
#  state                 :string(255)
#  zip                   :string(255)
#  email_1               :string(255)
#  email_2               :string(255)
#  email_3               :string(255)
#  helpline              :string(255)
#  phone_1               :string(255)
#  phone_2               :string(255)
#  latitude              :float
#  longitude             :float
#  ein                   :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  gmaps                 :boolean
#  gmaps_address         :string(255)
#  radius                :integer
#  category              :string(255)
#  separate_exemption    :boolean
#  inactive              :boolean
#  database_identifier   :string(255)
#  email_1_import_id     :string(255)
#  email_2_import_id     :string(255)
#  email_3_import_id     :string(255)
#  helpline_import_id    :string(255)
#  phone_1_import_id     :string(255)
#  phone_2_import_id     :string(255)
#  address_import_id     :string(255)
#  independent_import_id :string(255)
#  ein_import_id         :string(255)
#
require 'open-uri'

class Chapter < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :attachments
  has_many :chapter_leaders
  has_many :leaders, through: :chapter_leaders
  has_paper_trail

  attr_accessible :city, :ein, :email_1, :email_2, :email_3, :helpline, :latitude, :longitude, :name, :phone_1, :phone_2, :state, :street, :website, :zip, :radius, :category, :inactive, :separate_exemption, :users_attributes, :database_identifier, :attachment_ids, :bylaws, :attachments_attributes, :email_1_import_id, :email_2_import_id, :email_3_import_id, :helpline_import_id, :phone_1_import_id, :phone_2_import_id, :address_import_id, :independent_import_id, :ein_import_id, :revoked, :revocation_date
 # acts_as_gmappable :lat => 'latitude', :lng => 'longitude', :validation => false, :process_geocoding => true, :checker => "gmaps", :check_process => true, 
 #                 :address => "address", :normalized_address => "gmaps_address"

  accepts_nested_attributes_for :attachments, :allow_destroy => true

  scope :active, where("inactive = ? OR inactive is ?",false,nil)
  scope :representatives, where("category = ?","Representative")
  scope :chapters_only, where("category = ?","Chapter")
  scope :ungeo, where("latitude = ? or longitude is ?", nil, nil)

  before_validation do
    self.ein = "%09d" % ein.gsub(/[^0-9]/, "").to_i if attribute_present?("ein")
    if self.latitude.blank? or self.longitude.blank?
      self.geocode
    end
  end

  validates_length_of :ein, :minimum => 9, :maximum => 9, :unless => Proc.new {|c| c.ein.blank? }
  validates :name, presence: true
  validates :ein, numericality: true, :unless => Proc.new { |c| c.ein.blank? }

  geocoded_by :geo_address

  RAISERS_EDGE_FIELD_MAP = {"CnBio_ID" => "database_identifier",
    "CnBio_Import_ID" => "CnBio_Import_ID",
    "CnBio_Org_Name" => "name",
    "CnBio_Constit_Code" => "category", 
    "CnBio_Inactive" => "inactive",
    "CnAdrPrf_Addrline1" => "address_line_1",
    "CnAdrPrf_Addrline2" => "address_line_2",
    "CnAdrPrf_Addrline3" => "address_line_3",
    "CnAdrPrf_Addrline4" => "address_line_4",
    "CnAdrPrf_Addrline5" => "address_line_5",
    "CnAdrPrf_City" => "city",
    "CnAdrPrf_ContryLongDscription" => "country",
    "CnAdrPrf_OrgName" => "CnAdrPrf_OrgName",
    "CnAdrPrf_Position" => "CnAdrPrf_Position",
    "CnAdrPrf_State" => "state",
    "CnAdrPrf_ZIP" => "zip",
    "CnAdrPrf_Import_ID" => "address_import_id",
    "CnAdrPrfPh_1_01_Phone_number" => "email_1",
    "CnAdrPrfPh_1_01_Import_ID" => "email_1_import_id",
    "CnAdrPrfPh_2_01_Phone_number" => "email_2",
    "CnAdrPrfPh_2_01_Import_ID" => "email_2_import_id",
    "CnAdrPrfPh_3_01_Phone_number" => "helpline",
    "CnAdrPrfPh_3_01_Import_ID" => "helpline_import_id",
    "CnAdrPrfPh_4_01_Phone_number" => "phone_1",
    "CnAdrPrfPh_4_01_Import_ID" => "phone_1_import_id",
    "CnAdrPrfPh_5_01_Phone_number" => "phone_2",
    "CnAdrPrfPh_5_01_Import_ID" => "phone_2_import_id",
    "CnAdrPrfPh_6_01_Phone_number" => "website",
    "CnAdrPrfPh_6_01_Import_ID" => "website_import_id",
    "CnAdrPrfPh_7_01_Phone_number" => "phone_3",
    "CnAdrPrfPh_7_01_Import_ID" => "phone_3_import_id",
    "CnAttrCat_1_01_Description" => "separate_exemption",
    "CnAttrCat_1_01_Import_ID" => "separate_exemption_import_id",
    "CnAttrCat_2_01_Description" => "ein",
    "CnAttrCat_2_01_Import_ID" => "ein_import_id"}

  def address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    address = [self.street, (self.city + "," unless self.city.blank?), self.state, self.zip].reject{|h| h.blank?}.join(" ")
    "#{address} United States"
  end

  def city_state_zip
    [(self.city + "," unless self.city.blank?), self.state, self.zip].reject{|h| h.blank?}.join(" ")
  end

  def vague_address
    address = [(self.city + "," unless self.city.blank?), self.state, self.zip].reject{|h| h.blank?}.join(" ")
  end

  def representative?
    self.category == "Representative"
  end

  def chapter?
    self.category == "Chapter"
  end


  def geo_address
    geocode_address = ""
    if (self.category == "Representative")
      geocode_address = self.vague_address
    else
      geocode_address = self.address
    end
    geocode_address
  end

  def website_url
    url = self.website
    unless url.blank? || url[/\Ahttp:\/\//] || url[/\Ahttps:\/\//]
      url = "http://#{url}"
    end
    url
  end

  def city_state_zip
  [(self.city + "," unless self.city.blank?),self.state,self.zip].join(" ");
  end

  def self.import(file)
    errors = Array.new
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    header.map! { |h| RAISERS_EDGE_FIELD_MAP[h] || h.downcase  }
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
#      logger.info("row: " + row.to_hash.slice(*accessible_attributes).map{|k,v| "#{k}=#{v}" }.join(','))
#      logger.info ("header " + header.to_s)

      address_lines = row.select { |k,v| /^address(_line_\d)*$/.match(k) && !v.blank? && v != "" }.map{|k,v| v}.join("\n")
      row["street"] ||= address_lines unless address_lines.blank?
     
      chapter = find_by_database_identifier(row["database_identifier"]) || 
                (find_by_ein(row["ein"]) unless row["ein"].blank?) ||
                find_by_id(row["id"]) ||
                new
      
      chapter.attributes = row.to_hash.slice(*accessible_attributes)
      chapter.geocode
      chapter.save!
      sleep 0.05
    end
       errors
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.to_csv(chapters, options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      chapters.each do |chapter|
        csv << chapter.attributes.values_at(*column_names)
      end
    end
  end

  def self.search(search)
    Chapter.select{|h| h.name.downcase.include? search}
  end

  def self.find_by_did(name)
    Chapter.find_by_database_identifier name
  end

  def self.find_by_email(email)
    email.downcase!
    Chapter.find(:all, :conditions => ["lower(email_1) = ? OR lower(email_2) = ? OR lower(email_3) = ?", email,email,email]) 
  end

  def update_revocation_status
    unless self.revoked? || self.ein.blank?
      ein = self.ein
      url = "http://apps.irs.gov/app/eos/revokeSearch.do?ein1=#{ein}&names=&city=&state=All...&zipCode=&country=US&exemptTypeCode=al&postDateFrom=&postDateTo=&dispatchMethod=searchRevocation&submitName=Search"
      html = Nokogiri::HTML(open(url).read)
      self.revoked = !html.css("div.content").children[6].text.include?("There were no organizations found matching the search values you entered")
      self.revocation_date = Date.parse(html.css('tr')[3].children[14].text) if (self.revoked)
      self.save!
    end
  end

  def self.update_all_revocation_status
    Chapter.all.each{|h| h.update_revocation_status}
  end


end

