class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_many :todo, :dependent => :destroy
  has_many :item, :dependent => :destroy
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
