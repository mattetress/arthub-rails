class Comment < ApplicationRecord
  belongs_to :user, :event
end
