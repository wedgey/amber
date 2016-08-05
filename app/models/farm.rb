class Farm < ApplicationRecord
  belongs_to :user
  has_many :sub_farms
  has_many :stock
end
