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

  def self.tags
  	["EIN Letter","IRS Determination Letter","Affiliation Agreement", "Bylaws", "Articles of Incorporation"]
  end

end
