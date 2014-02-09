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

require 'spec_helper'

describe ChapterLeader do
  pending "add some examples to (or delete) #{__FILE__}"
end
