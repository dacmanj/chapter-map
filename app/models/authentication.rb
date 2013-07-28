# == Schema Information
#
# Table name: authentications
#
#  id         :integer          primary key
#  user_id    :integer
#  provider   :string(255)
#  uid        :string(255)
#  created_at :timestamp        not null
#  updated_at :timestamp        not null
#

class Authentication < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id
  belongs_to :user

  def self.create_with_omniauth(auth)
    create(uid: auth['uid'], provider: auth['provider']) # and other data you might want from the auth hash
  end

  def self.find_with_omniauth(auth)
    find_by_provider_and_uid(auth['provider'], auth['uid'])
  end

end
