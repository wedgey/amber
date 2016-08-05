class SubFarm < ApplicationRecord
  belongs_to :farm
  belongs_to :crop
end
