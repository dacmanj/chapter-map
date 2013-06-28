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
  has_and_belongs_to_many :chapters

  attr_accessible :provider, :uid, :name, :email, :admin, :chapter_ids
  validates_presence_of :name
  validates_uniqueness_of :email

  def self.create_with_omniauth(auth)
    email = auth["info"]["email"]
    domain = /@(.+$)/.match(email)[1]
    if (domain.casecmp("pflag.org") != 0)
#      raise UserDomainError, "#{domain} is not an authorized domain."
      create! do |user|
        user.provider = auth['provider']
        user.uid = auth['uid']
        user.admin = false
        user.chapters.push(Chapter.find_by_email(email))
        if auth['info']
           user.name = auth['info']['name'] || ""
           user.email = auth['info']['email'] || ""
        end
      end
    else
      create! do |user|
        user.provider = auth['provider']
        user.uid = auth['uid']
        user.admin = true
        if auth['info']
           user.name = auth['info']['name'] || ""
           user.email = auth['info']['email'] || ""
        end
      end
    end
  end

  def name_and_email
    unless name.blank? || email.blank?
      name + " (" + email + ")"
    end
  end


  def self.find_by_email(email)
    unless email.blank?
      email.downcase! 
      User.find(:all, :conditions => ["lower(email) = ?",email]).first 
    end
  end

end


class UserDomainError < StandardError
end
