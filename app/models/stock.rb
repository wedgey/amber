class Stock < ApplicationRecord
  belongs_to :farm
  belongs_to :resource
end
