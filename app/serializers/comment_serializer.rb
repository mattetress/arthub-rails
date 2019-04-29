class CommentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :user_id, :user_name, :event_id, :body, :created_at, :updated_at, :user_avatar

  def user_name
    object.user.name
  end

  def user_avatar
    if object.user.avatar.attached?
      variant = object.user.avatar.variant(resize: "64x64")
      rails_representation_url(variant, only_path: true)
    else
      "/assets/profile64.png"
    end
  end
end
