# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)      default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
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
#  override_sync          :boolean
#

#class User < OmniAuth::Identity::Models::ActiveRecord
class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2, :facebook]

  # Setup accessible (or protected) attributes for your model
#  attr_accessible :email, :password, :password_confirmation, :remember_me
#  attr_accessible :name, :email, :admin, :chapter_ids, :password, :password_confirmation, :role_ids, :override_sync
  has_and_belongs_to_many :chapters
  has_many :attachments, :through => :chapters
  has_many :chapter_leaders, :through => :chapters
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

  def has_no_password?
    return self.encrypted_password.blank?
  end

#  def attachments
#    if self.has_role :admin
#      return Attachment.all
#    else
#      return self.chapters.collect(&:attachments).flatten
#    end
#  end

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

  def self.find_for_omniauth(auth, signed_in_resource=nil)
    @authentication = Authentication.find_with_omniauth(auth)
    if @authentication.blank? || @authentication.user.blank?
      user = User.create_from_omniauth(auth)
    else
      user = @authentication.user
    end
    user
  end

  def self.create_from_omniauth(auth)
    @authentication = Authentication.find_with_omniauth(auth)

    if (!auth["info"].blank?)
      email = auth["info"]["email"]
      name = auth["info"]["name"]
    elsif (!auth["name"].blank? && !auth["email"].blank?)
      email = auth["email"]
      name = auth["name"]
    end

    domain = /@(.+$)/.match(email)[1]
    admin = domain.casecmp("pflag.org") != 0 ? false : true

    if !admin
      raise UserDomainError, "Sorry! This site is not quite ready for you yet!"
    end

    user = User.find_by_email(email)


    if user.blank?
      chapters = Chapter.find_by_email(email)
      if chapters.blank? && !admin
        raise UserDomainError, "#{email} is not found please email info@pflag.org."
          ""
      end
      user = create! do |u|
          u.chapters.push(chapters) unless chapters.blank?
          if admin
            u.add_role :admin 
          else
            u.add_role :chapter_leader
          end

          u.authentications.build
          u.name = name || ""
          u.email = email || ""
          u.skip_confirmation! 
      end
    end
    if @authentication.blank?
      Authentication.create_with_omniauth(auth,user)
    elsif @authentication.user.blank?
       @authentication.user = user
       @authentication.save
    end
    return user
  end

  def update_without_password(params, *options)
    params.delete(:current_password)
    if (params[:password].blank? or params[:password] != params[:password_confirmation])
        params.delete(:password)
        params.delete(:password_confirmation)
    end
    result = update_attributes(user_params(params), *options)
    clean_up_passwords
    result    
  end

  def password_required?
    !self.has_no_password? && super
  end
  private
  def user_params(params)
    params.permit(:email, :password, :password_confirmation, :remember_me, :name, :admin, 
      :chapter_ids, :password, :password_confirmation, :role_ids, :override_sync)
    
  end
end

class UserDomainError < StandardError
end
