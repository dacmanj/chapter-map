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

require 'spec_helper'

describe Leader do
  pending "add some examples to (or delete) #{__FILE__}"
end
