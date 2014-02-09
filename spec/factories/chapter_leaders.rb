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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :chapter_leader do
    chapter_id 1
    leader_id 1
    position_1 "MyString"
    position_2 "MyString"
    position_3 "MyString"
    position_4 "MyString"
    position_5 "MyString"
    spouse_position_1 "MyString"
    spouse_position_2 "MyString"
    spouse_position_3 "MyString"
    spouse_position_4 "MyString"
    spouse_position_5 "MyString"
  end
end
