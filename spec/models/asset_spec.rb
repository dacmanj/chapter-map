# == Schema Information
#
# Table name: assets
#
#  id                      :integer          primary key
#  created_at              :timestamp        not null
#  updated_at              :timestamp        not null
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :timestamp
#  chapter_id              :integer
#  tag                     :string(255)
#

require 'spec_helper'

describe Asset do
  pending "add some examples to (or delete) #{__FILE__}"
end
