# == Schema Information
#
# Table name: chapter_leaders
#
#  id                        :integer          not null, primary key
#  chapter_id                :integer
#  member_id                 :integer
#  position                  :string(255)
#  spouse_position           :string(255)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  position_import_id        :string(255)
#  spouse_position_import_id :string(255)
#

class ChapterLeader < ActiveRecord::Base
#  attr_accessible :chapter_id, :leader_id, :position_1, :position_2, :position_3, :position_4, :position_5, :spouse_position_1, :spouse_position_2, :spouse_position_3, :spouse_position_4, :spouse_position_5
  belongs_to :chapter
  belongs_to :member

  def self.positions
  	["","Board Member","President","Vice President","Treasurer","Secretary","Executive Director","Co-President","Communications Coordinator","Diversity Coordinator","Advocacy Coordinator","Fundraising Coordinator","Membership Coordinator","Safe Schools Coordinator","Speakers Bureau Coordinator","State Coordinator","Transgender Coordinator","Programs Coordinator","Web Manager"]
  end
end
