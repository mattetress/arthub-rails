class Location < ApplicationRecord
  belongs_to :city
  belongs_to :event 
end
