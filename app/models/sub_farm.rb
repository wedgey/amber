class SubFarm < ApplicationRecord
  belongs_to :farm
  belongs_to :crop
  has_many :sub_farm_activities
end
