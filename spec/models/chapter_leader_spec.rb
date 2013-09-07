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

require 'spec_helper'

describe ChapterLeader do
  pending "add some examples to (or delete) #{__FILE__}"
end
