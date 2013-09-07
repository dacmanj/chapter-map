# == Schema Information
#
# Table name: chapters
#
#  id                        :integer          primary key
#  name                      :string(255)
#  website                   :string(255)
#  street                    :string(255)
#  city                      :string(255)
#  state                     :string(255)
#  zip                       :string(255)
#  email_1                   :string(255)
#  email_2                   :string(255)
#  email_3                   :string(255)
#  helpline                  :string(255)
#  phone_1                   :string(255)
#  phone_2                   :string(255)
#  latitude                  :float
#  longitude                 :float
#  ein                       :string(255)
#  created_at                :timestamp        not null
#  updated_at                :timestamp        not null
#  gmaps                     :boolean
#  gmaps_address             :string(255)
#  radius                    :integer
#  category                  :string(255)
#  separate_exemption        :boolean
#  inactive                  :boolean
#  database_identifier       :string(255)
#  chapter_legacy_identifier :string(255)
#  bylaws_file_name          :string(255)
#  bylaws_content_type       :string(255)
#  bylaws_file_size          :integer
#  bylaws_updated_at         :timestamp
#  email_1_import_id         :string(255)
#  email_2_import_id         :string(255)
#  email_3_import_id         :string(255)
#  helpline_import_id        :string(255)
#  phone_1_import_id         :string(255)
#  phone_2_import_id         :string(255)
#  address_import_id         :string(255)
#  independent_import_id     :string(255)
#  ein_import_id             :string(255)
#

class Chapter < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :attachments
  has_many :chapter_leaders
  has_many :leaders, through: :chapter_leaders
  has_attached_file :bylaws


  attr_accessible :city, :ein, :email_1, :email_2, :email_3, :helpline, :latitude, :longitude, :name, :phone_1, :phone_2, :state, :street, :website, :zip, :radius, :category, :inactive, :separate_exemption, :users_attributes, :chapter_legacy_identifier, :database_identifier, :attachment_ids, :bylaws, :attachments_attributes, :email_1_import_id, :email_2_import_id, :email_3_import_id, :helpline_import_id, :phone_1_import_id, :phone_2_import_id, :address_import_id, :independent_import_id, :ein_import_id
  acts_as_gmappable :lat => 'latitude', :lng => 'longitude',:validation => false, :process_geocoding => :geocode, :check_process => true, :checker => "gmaps",
                  :address => "address", :normalized_address => "gmaps_address"

  accepts_nested_attributes_for :attachments, :allow_destroy => true

  scope :active, where("inactive = ? OR inactive is ?",false,nil)

  before_validation do
    self.ein = "%09d" % ein.gsub(/[^0-9]/, "") if attribute_present?("ein")
  end

  validates_length_of :ein, :minimum => 9, :maximum => 9, :unless => Proc.new {|c| c.ein.blank? }
  validates :name, presence: true
  validates :ein, numericality: true, :unless => Proc.new { |c| c.ein.blank? }

  geocoded_by :address

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

  def geocode?
    (!city.blank? && !state.blank?) && (latitude.blank? || longitude.blank?) #|| address_changed?
  end

  def address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    address = [self.street, (self.city + "," unless self.city.blank?), self.state, self.zip].reject{|h| h.blank?}.join(" ")
    "#{address} United States"
  end

  def self.import(file)
    errors = Array.new
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    header.map! { |h| RAISERS_EDGE_FIELD_MAP[h] || h.downcase  }
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      logger.info("row: " + row.to_hash.slice(*accessible_attributes).map{|k,v| "#{k}=#{v}" }.join(','))
      logger.info ("header " + header.to_s)

      row["street"] = row.select { |k,v| /^address(_line_\d)*$/.match(k) && !v.blank? && v != "" }.map{|k,v| v}.join("\n")
      #= row.reject { |k,v| !k.match("^address") && !k.match("id$") || v.blank? || v == "" }.map {|k,v| v }.join("\n")
      row["database_identifier"] ||= row["chapter_legacy_identifier"]
      row["chapter_legacy_identifier"] ||= row["database_identifier"]
      
      chapter = find_by_database_identifier(row["database_identifier"]) || find_by_ein(row["ein"]) || find_by_id(row["id"]) || new
      chapter.attributes = row.to_hash.slice(*accessible_attributes)
      chapter.save!
    end
       errors
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
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

  def self.search(name)
    name = name.downcase
    Chapter.find(:all, :conditions => ["lower(name) LIKE ?","%#{name}%"])
  end

  def self.find_by_cid(name)
    Chapter.find_by_chapter_legacy_identifier name
  end

  def self.find_by_email(email)
    email.downcase!
    Chapter.find(:all, :conditions => ["lower(email_1) = ? OR lower(email_2) = ? OR lower(email_3) = ?", email,email,email]) 
  end



end

