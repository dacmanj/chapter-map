# == Schema Information
#
# Table name: leaders
#
#  id                      :integer          not null, primary key
#  contituent_id           :string(255)
#  first_name              :string(255)
#  last_name               :string(255)
#  chapter_code            :string(255)
#  spouse_first_name       :string(255)
#  spouse_last_name        :string(255)
#  address                 :string(255)
#  address_2               :string(255)
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
#

class Leader < ActiveRecord::Base
  attr_accessible :address, :address_2, :address_import_id, :chapter_code, :city, :contituent_id, :email, :email_import_id, :first_name, :last_name, :phone, :phone_import_id, :position_1, :position_2, :position_3, :position_4, :position_5, :spouse_first_name, :spouse_last_name, :spouse_position_1, :spouse_position_2, :spouse_position_3, :spouse_position_4, :spouse_position_5, :state, :zip, :suppress_from_directory
  has_many :chapter_leaders
  has_many :chapters, through: :chapter_leaders
  has_many :users, through: :chapters

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
