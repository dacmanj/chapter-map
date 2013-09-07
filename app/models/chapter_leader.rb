# == Schema Information
#
# Table name: chapter_leaders
#
#  id                :integer          not null, primary key
#  chapter_id        :integer
#  leader_id         :integer
#  position_1        :string(255)
#  position_2        :string(255)
#  position_3        :string(255)
#  position_4        :string(255)
#  position_5        :string(255)
#  spouse_position_1 :string(255)
#  spouse_position_2 :string(255)
#  spouse_position_3 :string(255)
#  spouse_position_4 :string(255)
#  spouse_position_5 :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class ChapterLeader < ActiveRecord::Base
  attr_accessible :chapter_id, :leader_id, :position_1, :position_2, :position_3, :position_4, :position_5, :spouse_position_1, :spouse_position_2, :spouse_position_3, :spouse_position_4, :spouse_position_5
end
