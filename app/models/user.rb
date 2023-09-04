class User < ApplicationRecord
  has_many :devices
  has_one :sms_configuration
  has_many :sellers, foreign_key: "creator_id"


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         enum role: { admin: 'admin', user: 'user'}
end




