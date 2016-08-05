class User < ApplicationRecord
  has_many :farms
  
  has_secure_password

  # validates :username, uniqueness: true
  validates :password, length: { in: 6..20 }, on: :create
  
end
