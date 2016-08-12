class Farm < ApplicationRecord
  belongs_to :user
  has_many :sub_farms
  has_many :stock

  validates :name, presence: true
  validates :user_id, presence: true
  validates :size, numericality: true
end
