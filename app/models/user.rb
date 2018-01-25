class User < ApplicationRecord
  validates :name, presence: true, null: false
  validates :email, presence: true, uniqueness: true, null: false
  has_many :todo, :dependent => :destroy
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
