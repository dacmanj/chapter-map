# == Schema Information
#
# Table name: users
#
#  id              :integer          primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :timestamp        not null
#  updated_at      :timestamp        not null
#  admin           :boolean
#  password_digest :string(255)
#  activation_code :string(255)
#

class User < OmniAuth::Identity::Models::ActiveRecord
  attr_accessible :name, :email, :admin, :chapter_ids, :password, :password_confirmation
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

  def attachments
    if self.admin?
      return Attachment.all
    else
      return self.chapters.collect(&:attachments).flatten
    end
  end

  def chapters
    if self.admin?
      Chapter.all
    else
      super
    end
  end

  def leaders
    if self.admin?
      Leader.all
    else
      return self.chapters.collect(&:leaders).flatten
    end
  end

  def self.find_by_email(email)
    unless email.blank?
      email.downcase! 
      User.find(:all, :conditions => ["lower(email) = ?",email]).first 
    end
  end

  def self.activate(params)
    u = self.find_by_email_and_activation_code(params[:email],params[:code])
    unless u.nil?
      u.activation_code = nil
      u.save
      u = true
    end
    u
  end

  def self.special_initialize(user)
    unless user.nil? 
      domain = /@(.+$)/.match(user.email)[1]
      user.activation_code = rand(36**10).to_s(36)
      user.chapters.push(Chapter.find_by_email(user.email))
      user.admin = domain.casecmp("pflag.org") != 0 ? false : true
      user.save
    end
  end

  def self.create_with_omniauth(auth)
    if (!auth["info"].blank?)
      email = auth["info"]["email"]
      name = auth["info"]["name"]
    elsif (!auth["name"].blank? && !auth["email"].blank?)
      email = auth["email"]
      name = auth["name"]
    end

    domain = /@(.+$)/.match(email)[1]
    admin = domain.casecmp("pflag.org") != 0 ? false : true
    password = auth["password"]


    if Chapter.find_by_email(email).blank? && !admin
      raise UserDomainError, "#{email} is not found."
    end
    create! do |user|
        user.admin = false
        if password.blank?
          user.password_digest = rand(36**10).to_s(36)
        end
        user.chapters.push(Chapter.find_by_email(email))
        user.name = name || ""
        user.email = email || ""
        user.admin = admin
        user.activation_code = rand(36**20).to_s(36) unless auth["provider"] != "identify"
    end
  end
end

class UserDomainError < StandardError
end
