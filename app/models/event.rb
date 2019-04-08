class Event < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :interests
  has_many :comments
  has_many :users, through: :interests
  has_one :location, dependent: :destroy
  has_one :city, through: :location
  
  accepts_nested_attributes_for :location

  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :venue, presence: true
  validates :description, presence: true

  def self.past_events
    self.where("end_time < ?", Time.now).order('end_time desc')
  end

  def self.future_events
    self.where("end_time > ?", Time.now).order('start_time asc')
  end
end
