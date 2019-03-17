class Event < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :interests
  has_many :users, through: :interests
end
