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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :leader do
    contituent_id "MyString"
    first_name "MyString"
    last_name "MyString"
    chapter_code "MyString"
    position_1 "MyString"
    position_2 "MyString"
    position_3 "MyString"
    position_4 "MyString"
    position_5 "MyString"
    spouse_first_name "MyString"
    spouse_last_name "MyString"
    spouse_position_1 "MyString"
    spouse_position_2 "MyString"
    spouse_position_3 "MyString"
    spouse_position_4 "MyString"
    spouse_position_5 "MyString"
    address "MyString"
    address_2 "MyString"
    city "MyString"
    state "MyString"
    zip "MyString"
    phone "MyString"
    email "MyString"
    address_import_id "MyString"
    phone_import_id "MyString"
    email_import_id "MyString"
  end
end
