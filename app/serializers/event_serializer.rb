class EventSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :user_id, :name, :description, :city, :area, :image_url, :image_url_400, :image_url_full, :start_time, :end_time, :venue, :accepting_applications, :user_count, :created_at
  has_many :users
  belongs_to :owner
  has_many :comments

  def image_url
    if object.image.attached?
      variant = object.image.variant(resize: "150x150")
      rails_representation_url(variant, only_path: true)
    end
  end

  def image_url_400
    if object.image.attached?
      variant = object.image.variant(resize: "400x400")
      rails_representation_url(variant, only_path: true)
    end
  end

  def area
    object.location.area
  end

  def image_url_full
    if object.image.attached?
      rails_blob_path(object.image, :only_path => true)
    end
  end

  def user_count
    object.users.count
  end

  def owner
    object.user
  end
end
