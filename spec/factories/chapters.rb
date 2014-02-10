# == Schema Information
#
# Table name: chapters
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
#  website               :string(255)
#  street                :string(255)
#  city                  :string(255)
#  state                 :string(255)
#  zip                   :string(255)
#  email_1               :string(255)
#  email_2               :string(255)
#  email_3               :string(255)
#  helpline              :string(255)
#  phone_1               :string(255)
#  phone_2               :string(255)
#  latitude              :float
#  longitude             :float
#  ein                   :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  gmaps                 :boolean
#  gmaps_address         :string(255)
#  radius                :integer
#  category              :string(255)
#  separate_exemption    :boolean
#  inactive              :boolean
#  database_identifier   :string(255)
#  email_1_import_id     :string(255)
#  email_2_import_id     :string(255)
#  email_3_import_id     :string(255)
#  helpline_import_id    :string(255)
#  phone_1_import_id     :string(255)
#  phone_2_import_id     :string(255)
#  address_import_id     :string(255)
#  independent_import_id :string(255)
#  ein_import_id         :string(255)
#  revoked               :boolean
#  revocation_date       :date
#  position_lock         :boolean
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :chapter do
    name "MyString"
    website "MyString"
    street "MyString"
    city "MyString"
    state "MyString"
    zip "MyString"
    email_1 "MyString"
    email_2 "MyString"
    email_3 "MyString"
    helpline "MyString"
    phone_1 "MyString"
    phone_2 "MyString"
    latitude 1.5
    longitude 1.5
    ein "MyString"
  end
end
