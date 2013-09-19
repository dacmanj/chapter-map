# == Schema Information
#
# Table name: chapters
#
#  id                        :integer          primary key
#  name                      :string(255)
#  website                   :string(255)
#  street                    :string(255)
#  city                      :string(255)
#  state                     :string(255)
#  zip                       :string(255)
#  email_1                   :string(255)
#  email_2                   :string(255)
#  email_3                   :string(255)
#  helpline                  :string(255)
#  phone_1                   :string(255)
#  phone_2                   :string(255)
#  latitude                  :float
#  longitude                 :float
#  ein                       :string(255)
#  created_at                :timestamp        not null
#  updated_at                :timestamp        not null
#  gmaps                     :boolean
#  gmaps_address             :string(255)
#  radius                    :integer
#  category                  :string(255)
#  separate_exemption        :boolean
#  inactive                  :boolean
#  database_identifier       :string(255)
#  chapter_legacy_identifier :string(255)
#  bylaws_file_name          :string(255)
#  bylaws_content_type       :string(255)
#  bylaws_file_size          :integer
#  bylaws_updated_at         :timestamp
#  email_1_import_id         :string(255)
#  email_2_import_id         :string(255)
#  email_3_import_id         :string(255)
#  helpline_import_id        :string(255)
#  phone_1_import_id         :string(255)
#  phone_2_import_id         :string(255)
#  address_import_id         :string(255)
#  independent_import_id     :string(255)
#  ein_import_id             :string(255)
#

require 'spec_helper'

describe Chapter do
  pending "add some examples to (or delete) #{__FILE__}"
end
