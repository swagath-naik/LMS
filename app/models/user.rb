class User < ApplicationRecord
  has_secure_password
  validates :username, uniqueness: true, presence: true
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, length: { minimum: 6 }
  
  belongs_to :profile, polymorphic: true, optional: true, dependent: :destroy
  accepts_nested_attributes_for :profile
  delegate :admin?, :role, to: :profile 
end
