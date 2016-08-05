class Resource < ApplicationRecord
  has_many :activities
  has_many :stocks
end
