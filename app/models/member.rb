# == Schema Information
#
# Table name: members
#
#  id                      :integer          not null
#  contituent_id           :string(255)
#  first_name              :string(255)
#  last_name               :string(255)
#  chapter_code            :string(255)
#  spouse_first_name       :string(255)
#  spouse_last_name        :string(255)
#  address                 :string(255)
#  city                    :string(255)
#  state                   :string(255)
#  zip                     :string(255)
#  phone                   :string(255)
#  email                   :string(255)
#  address_import_id       :string(255)
#  phone_import_id         :string(255)
#  email_import_id         :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  suppress_from_directory :boolean
#  chapter_id              :integer
#  import_id               :string(255)
#

class Member < ActiveRecord::Base
#  attr_accessible :address, :address_2, :address_import_id, :chapter_code, :city, :contituent_id, :email, :email_import_id, :first_name, :last_name, :phone, :phone_import_id, :spouse_first_name, :spouse_last_name, :state, :zip, :suppress_from_directory, :chapter_leaders_attributes
  has_many :chapter_leaders
  has_many :chapters, through: :chapter_leaders
  has_many :users, through: :chapters
  accepts_nested_attributes_for :chapter_leaders, :allow_destroy => true

  def link_to_chapter
  	unless chapter_code.empty?
  		self.chapter = Chapter.find_by_chapter_legacy_identifier chapter_code
  	end
  	self.chapter
  end

  def name
    "#{first_name} #{last_name}"
  end

  def chapter
  	if chapter_id.nil?
  		@self.link_to_chapter
  		Chapter.find(chapter_id) unless chapter_id.empty?
  	else
  		Chapter.find(chapter_id)
  	end
  end

end
