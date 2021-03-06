# == Schema Information
#
# Table name: chapters
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  website                :string(255)
#  street                 :string(255)
#  city                   :string(255)
#  state                  :string(255)
#  zip                    :string(255)
#  email_1                :string(255)
#  email_2                :string(255)
#  email_3                :string(255)
#  helpline               :string(255)
#  phone_1                :string(255)
#  phone_2                :string(255)
#  latitude               :float
#  longitude              :float
#  ein                    :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  gmaps                  :boolean
#  gmaps_address          :string(255)
#  radius                 :integer
#  category               :string(255)
#  separate_exemption     :boolean
#  inactive               :boolean
#  database_identifier    :string(255)
#  email_1_import_id      :string(255)
#  email_2_import_id      :string(255)
#  email_3_import_id      :string(255)
#  helpline_import_id     :string(255)
#  phone_1_import_id      :string(255)
#  phone_2_import_id      :string(255)
#  address_import_id      :string(255)
#  independent_import_id  :string(255)
#  ein_import_id          :string(255)
#  revoked                :boolean
#  revocation_date        :date
#  position_lock          :boolean
#  ambiguate_address      :boolean
#  twitter_url            :string(255)
#  twitter_url_import_id  :string(255)
#  facebook_url           :string(255)
#  facebook_url_import_id :string(255)
#  website_import_id      :string(255)
#  pending                :boolean
#  pending_reason         :string(255)
#

require 'open-uri'

class Chapter < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :attachments
  has_many :chapter_leaders
  has_many :members, through: :chapter_leaders
  has_paper_trail

  accepts_nested_attributes_for :attachments, :allow_destroy => true

  scope :active, lambda { where("(inactive = ? OR inactive is ?) and (pending = ? OR pending is ?)",false,nil,false,nil) }
  scope :inactive, lambda{ where("inactive = ?",true) }
  scope :pending, lambda { where("pending = ?",true) }
  scope :representatives, lambda { where("category = ?","Representative") }
  scope :revoked, lambda {where("revoked = ?",true) }
  scope :chapters_only, lambda {where("category = ?","Chapter")}
  scope :ungeo, lambda { where("latitude = ? or longitude is ?", nil, nil)}
  scope :unlocked, lambda {where("position_lock = ? or position_lock is ?",false,nil)}

  validates_uniqueness_of :database_identifier

  after_validation :geocode, if: ->(obj){ obj.address.present? and !obj.position_lock? and obj.address_changed?}

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
    "CnAdrPrfPh_8_01_Phone_number" => "facebook_url",
    "CnAdrPrfPh_8_01_Import_ID" => "facebook_url_import_id",
    "CnAdrPrfPh_9_01_Phone_number" => "twitter_url",
    "CnAdrPrfPh_9_01_Import_ID" => "twitter_url_import_id",
    "CnAttrCat_1_01_Description" => "separate_exemption",
    "CnAttrCat_1_01_Import_ID" => "separate_exemption_import_id",
    "CnAttrCat_2_01_Description" => "ein",
    "CnAttrCat_2_01_Import_ID" => "ein_import_id"}

  def self.export_map 
      RAISERS_EDGE_FIELD_MAP.invert     
  end
  def address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    address = [self.street, (self.city + "," unless self.city.blank?), self.state, self.zip].reject{|h| h.blank?}.join(" ")
    "#{address} United States"
  end

  def city_state_zip
    [(self.city + "," unless self.city.blank?), self.state, self.zip].reject{|h| h.blank?}.join(" ")
  end

  def vague_address
    address = [(self.city + "," unless self.city.blank?), self.state, "USA"].reject{|h| h.blank?}.join(" ")
  end

  def representative?
    self.category == "Representative"
  end

  def chapter?
    self.category == "Chapter"
  end

  def self.states
    chapters = Chapter.order(:state).group_by(&:state)
  end

  def self.for_select
    Chapter.all.map {|c| [:value => c.id, :label => c.name, :state => c.state]}.group_by {|c| c[2]}
  end

  def geo_address
    geocode_address = ""
    if (self.category == "Representative" or self.ambiguate_address?)
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
    logger.info ("header " + header.to_s)
    header.map! { |h| RAISERS_EDGE_FIELD_MAP[h] || h.downcase  }
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]

      booleans = ["separate_exemption","inactive", "revoked","position_lock"]

      booleans.each do |x|
        unless row[x].nil?
          value = row[x].downcase
          row[x] = "true" if value.in?(["yes","true"])
          row[x] = "false" if value.in?(["no","false"])
          throw 'invalid true/false import format' unless row[x].in? ['','true','false','yes','no']
        end
      end

      address_lines = row.select { |k,v| /^address(_line_\d)*$/.match(k) && !v.blank? && v != "" }.map{|k,v| v}.join("\n")
      row["street"] ||= address_lines
      logger.info("row: " + row.to_hash.slice(*importable_attributes).map{|k,v| "#{k}=#{v}" }.join(','))
     
      chapter = find_by_database_identifier(row["database_identifier"]) || 
                (find_by_ein(row["ein"]) unless row["ein"].blank?) ||
                find_by_id(row["id"]) ||
                new
      
      chapter.attributes = row.to_hash.slice(*importable_attributes)
      chapter.geocode if chapter.address.present? and !chapter.position_lock? and chapter.address_changed?
      begin
        chapter.save!
      rescue
        errors.push("Error on row #{i} #{$!}")
      end
    end
       errors
  end

  def coordinates
    [self.latitude, self.longitude]
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".CSV" then Roo::CSV.new(file.path)
    when ".xls" then Roo::Excel.new(file.path)
    when ".XLS" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    when ".XLSX" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.to_csv(chapters, options = {})
      re_column_names = column_names.map{|h| Chapter.export_map[h] || h}
    CSV.generate(options) do |csv|
        csv << re_column_names
      chapters.each do |chapter|
        csv << chapter.attributes.values_at(*column_names)
      end
    end
  end

  def self.search(params)
    search = "%#{params[:search]}%"

    case params[:show]
    when "active"
      self.active.where("name ILIKE ?", search)
    when "inactive"
      self.inactive.where("name ILIKE ?", search)

    when "pending"
      self.pending.where("name ILIKE ?", search)

    when "all"
      self.where("name ILIKE ?", search)
    else
      self.active.where("name ILIKE ?", search)

    end
  end

  def self.find_by_did(name)
    Chapter.find_by_database_identifier name
  end

  def self.find_by_email(email)
    email.downcase!
    Chapter.find(:all, :conditions => ["lower(email_1) = ? OR lower(email_2) = ? OR lower(email_3) = ?", email,email,email]) 
  end

  def revocation_url
    ein = self.ein
    url = "http://apps.irs.gov/app/eos/revokeSearch.do?ein1=#{ein}&names=&city=&state=All...&zipCode=&country=US&exemptTypeCode=al&postDateFrom=&postDateTo=&dispatchMethod=searchRevocation&submitName=Search"
  end
  
  def update_revocation_status
    count = 0
    unless self.revoked? || self.ein.blank?
      ein = self.ein
      url = "http://apps.irs.gov/app/eos/revokeSearch.do?ein1=#{ein}&names=&city=&state=All...&zipCode=&country=US&exemptTypeCode=al&postDateFrom=&postDateTo=&dispatchMethod=searchRevocation&submitName=Search"
      html = Nokogiri::HTML(open(url).read)
      self.revoked = !html.css("div.content").children[6].text.include?("There were no organizations found matching the search values you entered")
      self.revocation_date = Date.parse(html.css('tr')[3].children[14].text) if (self.revoked)
      if self.changed?
        logger.info("Revoked: #{self.database_identifier} #{name} #{revocation_date}") if self.revoked?
        count = 1
        self.save if self.changed?
      end
    end
    return count
  end

  def gmaps_marker_params
    # :url => "http://maps.google.com/intl/en_us/mapfiles/ms/micons/red-dot.png",
    #:url => "https://maps.google.com/mapfiles/ms/icons/purple.png", //(size 32x32)

    params = {:width => 24, :height => 24, :url => 
      case self.category
        when "Representative"
          '/assets/purple_24.png'
        when "Chapter"
          '/assets/purple_24.png'
        else
          '/assets/purple_24.png'
        end
        }
  end

  def self.update_all_revocation_status
    count = 0
    Chapter.all.each{|h| count += h.update_revocation_status}
    logger.info("Revocation Status update complete; #{count} updated")
  end

  def address_changed?
    ["street","city","state","zip", "ambiguate_address"].any? { |a| self.changed.include? a }
  end

  private
  def self.importable_attributes
    ["id", "name", "website", "street", "city", "state", "zip", "email_1", "email_2", "email_3", "helpline", "phone_1", "phone_2", "latitude", "longitude", "ein", "gmaps", "gmaps_address",
      "radius", "category", "separate_exemption", "inactive", "database_identifier", "email_1_import_id", "email_2_import_id", "email_3_import_id", "helpline_import_id", "phone_1_import_id", "phone_2_import_id", "address_import_id", "independent_import_id", "ein_import_id", "revoked", "revocation_date", "position_lock", "ambiguate_address", "twitter_url", "twitter_url_import_id", "facebook_url", "facebook_url_import_id", "website_import_id", "pending", "pending_reason", "meetings_trans", "meetings_multiple", "meetings_poc", "meetings_url", "meetings_trans_import_id", "meetings_multiple_import_id", "meetings_poc_import_id", "meetings_url_import_id"]
  end

end

