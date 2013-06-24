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

class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :email, :admin
  validates_presence_of :name

  def self.create_with_omniauth(auth)
    email = auth["info"]["email"]
    domain = /@(.+$)/.match(email)[1]
    if (domain.casecmp("pflag.org") != 0)
      raise UserDomainError, "#{domain} is not an authorized domain."
    else
      create! do |user|
        user.provider = auth['provider']
        user.uid = auth['uid']
        if auth['info']
           user.name = auth['info']['name'] || ""
           user.email = auth['info']['email'] || ""
        end
      end
    end
  end

end


class UserDomainError < StandardError
end
