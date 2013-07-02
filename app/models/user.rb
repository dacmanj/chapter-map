# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  admin      :boolean
#

class User < OmniAuth::Identity::Models::ActiveRecord
  attr_accessible :name, :email, :admin, :chapter_ids
  has_and_belongs_to_many :chapters
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_many :authentications

  validates_presence_of :name
  validates :email, :presence   => true,
            :format     => { :with => email_regex },
            :uniqueness => { :case_sensitive => false }

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

  def self.create_with_omniauth(auth)
    email = auth["info"]["email"]
    domain = /@(.+$)/.match(email)[1]
    if (domain.casecmp("pflag.org") != 0)
      if Chapter.find_by_email(email).blank?
        raise UserDomainError, "#{email} is not assigned to an authorized chapter leader."
      end
      create! do |user|
        user.admin = false
        user.password = rand(36**10).to_s(36)
        user.chapters.push(Chapter.find_by_email(email))
        if auth['info']
           user.name = auth['info']['name'] || ""
           user.email = auth['info']['email'] || ""
        end
      end
    else
      create! do |user|
        user.admin = true
        user.password = rand(36**10).to_s(36)
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
