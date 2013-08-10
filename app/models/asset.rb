# == Schema Information
#
# Table name: assets
#
#  id                      :integer          not null, primary key
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  chapter_id              :integer
#  tag                     :string(255)
#

class Asset < ActiveRecord::Base
  belongs_to :chapter
  attr_accessible :attachment, :tag
  has_attached_file :attachment
#  validate :attachment_presence => true
#  validate :tag, :presence => true

  include Rails.application.routes.url_helpers

  def self.tags
  	["EIN Letter","IRS Determination Letter","Affiliation Agreement", "Bylaws", "Articles of Incorporation"]
  end

  def self.search
  	@chapters = current_user.chapters
  	@assets_list = []
  	@chapters.each do |c|
  		c.assets.each do |a|
	  		@assets_list.push a
	  	end
	end

  end

  def to_jq
	{
	  "name" => read_attribute(:attachment_file_name),
	  "chapter" => self.chapter.name || "",
	  "tag" => self.tag,
	  "chapter_id" => read_attribute(:chapter_id),
	  "size" => read_attribute(:attachment_file_size),
	  "url" => attachment.url(:original),
	  "delete_url" => assets_path(self),
	  "delete_type" => "DELETE" 
	}
  end

end
