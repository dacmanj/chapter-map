# == Schema Information
#
# Table name: users
#
#  id         :integer          primary key
#  name       :string(255)
#  email      :string(255)
#  provider   :string(255)
#  uid        :string(255)
#  created_at :timestamp        not null
#  updated_at :timestamp        not null
#  admin      :boolean
#

require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end
