# == Schema Information
#
# Table name: authentications
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  provider   :string(255)
#  uid        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Authentication < ActiveRecord::Base
#  attr_accessible 
  belongs_to :user
    scope :provider, -> (provider) { where provider: provider }
    scope :uid, -> (uid) { where uid: uid }


  def self.allowed_attributes
  	[:provider, :uid, :user_id]
  end

  def self.create_with_omniauth(auth, user=nil)
    create(uid: auth['uid'], provider: auth['provider'], user_id: user.id) # and other data you might want from the auth hash
  end

  def self.find_with_omniauth(auth)
      self.find_by_provider_and_uid(auth['provider'], auth['uid'])
  end

end
