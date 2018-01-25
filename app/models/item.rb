class Item < ApplicationRecord
  validates :title, presence: true, uniqueness: { constraint: -> { where(user_id: @current_user) }}
  belongs_to :todo
end
