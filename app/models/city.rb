class City < ApplicationRecord
  has_many :locations
  has_many :events, through: :locations
end
