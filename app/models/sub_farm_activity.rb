class SubFarmActivity < ApplicationRecord
  belongs_to :sub_farm
  belongs_to :activity
  has_one :farm, through: :sub_farm
end
