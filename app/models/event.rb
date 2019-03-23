class Event < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :interests, :comments 
  has_many :users, through: :interests

  def self.past_events
    self.where("end_time < ?", Time.now).order('end_time desc')
  end

  def self.future_events
    self.where("end_time > ?", Time.now).order('start_time asc')
  end
end
