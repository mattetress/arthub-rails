class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :bio, :website
end
