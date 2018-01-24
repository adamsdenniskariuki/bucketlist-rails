class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_many :todo, dependent: :delete_all
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
