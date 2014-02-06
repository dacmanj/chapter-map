# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)      default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin                  :boolean
#  password_digest        :string(255)
#  activation_code        :string(255)
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#

#class User < OmniAuth::Identity::Models::ActiveRecord
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2, :facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
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

  def search(s,i)
    c = self.chapters
    s = s.downcase
    i = (i == "yes")

    c = c.select{ |h| h.inactive? == i }
    c = c.select{|h| h.name.downcase.include? s} unless s.blank?

    c
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

  def self.find_for_omniauth(auth, signed_in_resource=nil)
    authentication = Authentication.find_by_provider_and_uid(auth["provider"],auth["uid"])
    authentication.user

  end

  def self.create_from_omniauth(auth)
    @authentication = Authentication.find_with_omniauth(auth)
    if @authentication.nil?
      # If no authentication was found, create a brand new one here
      @authentication = Authentication.create_with_omniauth(auth)
    end

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

    if !admin
      raise UserDomainError, "Sorry! This site is not quite ready for you yet!"
    end

    if Chapter.find_by_email(email).blank? && !admin
      raise UserDomainError, "#{email} is not found."
    end
    new_user = create! do |user|
        user.admin = false
        if password.blank?
          user.password_digest = rand(36**10).to_s(36)
        end
        user.chapters.push(Chapter.find_by_email(email))
        user.name = name || ""
        user.email = email || ""
        user.admin = admin
        user.activation_code = rand(36**20).to_s(36) if auth["provider"] == "identify"
    end

    @authentication.user = new_user
    new_user

  end
end

class UserDomainError < StandardError
end
