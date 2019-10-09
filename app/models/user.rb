class User < ApplicationRecord
  has_secure_password
  validates :username, uniqueness: true, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :profile_type, presence: true 
  belongs_to :profile, polymorphic:true
end
