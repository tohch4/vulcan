class User < ApplicationRecord
  
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
         
  has_and_belongs_to_many :projects
  has_many :project_control_histories
  has_many :project_histories
  has_many :host_configs
  has_many :requests
  has_and_belongs_to_many :vendors
  # accepts_nested_attributes_for :vendor
  has_and_belongs_to_many :sponsor_agencies
  # accepts_nested_attributes_for :sponsor_agency
  
  def self.from_omniauth(auth)  
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      puts "HERE"
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end
