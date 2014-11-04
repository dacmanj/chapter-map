# == Schema Information
#
# Table name: attachments
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
#  user_id                 :integer
#

class Attachment < ActiveRecord::Base
  belongs_to :chapter
#  attr_accessible :attachment, :tag, :chapter_id, :user_id

  Paperclip.interpolates :chapter_id do |attachment, style|
    attachment.instance.chapter.database_identifier || "ID#{attachment.instance.chapter.id}" # or whatever you've named your User's login/username/etc. attribute
  end

  has_attached_file :attachment, {
        :path => "/:class/:chapter_id/:hash/:filename",
        :hash_secret => "C0n0mByoBzQWLk4cXJzJd9zxiJwcDe2X7@$BAiyrd7QoDphH9mC&i&jF^#R#0nc1"
  }
  validates_attachment_content_type :attachment, :content_type => %r{image/.*|application/pdf|application/msword.*|application/vnd.*|text/.*},
                                    :size => { :in => 0..10.megabytes}

#  validate :attachment_presence => true
#  validate :tag, :presence => true

  include Rails.application.routes.url_helpers

  def self.tags
  	["EIN Letter","IRS Determination Letter","Affiliation Agreement", "Bylaws", "Articles of Incorporation","Correspondence with National","Group Inclusion Letter","Verification Letter", "Other"]
  end

  def self.search
  	@chapters = current_user.chapters
  	@attachments_list = []
  	@chapters.each do |c|
  		c.attachments.each do |a|
	  		@attachments_list.push a
	  	end
   	end
  end

  def chapter_name
    if self.chapter.nil?
      return ""
    else
      return self.chapter.name
    end
  end


  def to_jq
	{
    "id" => read_attribute(:id),
	  "name" => read_attribute(:attachment_file_name),
	  "chapter" => self.chapter_name || "",
    "chapter_id" => self.chapter_id || "",
	  "tag" => self.tag,
	  "chapter_id" => read_attribute(:chapter_id),
	  "size" => read_attribute(:attachment_file_size),
	  "url" => attachment.url(:original),
	  "delete_url" => attachment_path(self),
	  "delete_type" => "DELETE" 
	}
  end

end
