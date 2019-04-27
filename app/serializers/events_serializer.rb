class EventsSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  
  attributes :id, :user_id, :name, :description, :image_url, :start_time, :end_time, :venue, :accepting_applications, :user_count
  has_many :users
  belongs_to :owner

  def image_url
    if object.image.attached?
      variant = object.image.variant(resize: "150x150")
      rails_representation_url(variant, only_path: true)
    end
  end

  def user_count
    object.users.count
  end

  def owner
    object.user
  end
end
