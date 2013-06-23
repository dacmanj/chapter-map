# == Schema Information
#
# Table name: chapters
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  website       :string(255)
#  street        :string(255)
#  city          :string(255)
#  state         :string(255)
#  zip           :string(255)
#  email_1       :string(255)
#  email_2       :string(255)
#  email_3       :string(255)
#  helpline      :string(255)
#  phone_1       :string(255)
#  phone_2       :string(255)
#  latitude      :float
#  longitude     :float
#  ein           :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  gmaps         :boolean
#  gmaps_address :string(255)
#  radius        :integer
#

require 'spec_helper'

describe Chapter do
  pending "add some examples to (or delete) #{__FILE__}"
end
