class EventsSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :image_url, :start_time, :end_time, :venue, :accepting_applications
  has_many :users

  def image_url
    variant = object.image.variant(resize: "150x150")
    return rails_representation_url(variant, only_path: true)
  end
end
