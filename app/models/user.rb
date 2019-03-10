class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar

  validates :email, uniqueness: :true,
                    presence: :true
  validates :password, presence: :true
end
