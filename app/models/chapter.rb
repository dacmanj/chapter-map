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
#  bylaws_updated_at         :datetime
#

class Chapter < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :attachments
  has_many :chapter_leaders
  has_many :leaders, through: :chapter_leaders
  has_attached_file :bylaws


  attr_accessible :city, :ein, :email_1, :email_2, :email_3, :helpline, :latitude, :longitude, :name, :phone_1, :phone_2, :state, :street, :website, :zip, :radius, :category, :inactive, :separate_exemption, :users_attributes, :chapter_legacy_identifier, :database_identifier, :attachment_ids, :bylaws, :attachments_attributes
  acts_as_gmappable :lat => 'latitude', :lng => 'longitude', :process_geocoding => :geocode?,
                  :address => "address", :normalized_address => "gmaps_address",
                  :msg => "Sorry, not even Google could figure out where that is",
                  :validate => false

  accepts_nested_attributes_for :attachments, :allow_destroy => true

  scope :active, where("inactive = ? OR inactive is ?",false,nil)

  before_validation do
    self.ein = ein.gsub(/[^0-9]/, "") if attribute_present?("ein")
  end

  validates_length_of :ein, :minimum => 9, :maximum => 9, :unless => Proc.new {|c| c.ein.blank? }
  validates :name, presence: true
  validates :ein, numericality: true

  geocoded_by :address

  def geocode?
    (!(street.blank? || city.blank? || state.blank?) && (latitude.blank? || longitude.blank?)) #|| address_changed?
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
      row["ein"] = row["ein"].gsub(/[^0-9]/, "") unless row["ein"].blank?
      logger.info("row: " + row.to_hash.slice(*accessible_attributes).map{|k,v| "#{k}=#{v}" }.join(','))
      chapter = find_by_id(row["id"]) || find_by_ein(row["ein"]) || new
      chapter.attributes = row.to_hash.slice(*accessible_attributes)
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

