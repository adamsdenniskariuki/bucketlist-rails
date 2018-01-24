class Todo < ApplicationRecord
  validates :title, presence: true
  belongs_to :user, dependent: :delete_all
  has_many :items
end
