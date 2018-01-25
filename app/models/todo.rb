class Todo < ApplicationRecord
  validates :title, presence: true, uniqueness: { constraint: -> { where(user_id: @current_user) }}
  belongs_to :user, :dependent => :destroy
  has_many :items
end
