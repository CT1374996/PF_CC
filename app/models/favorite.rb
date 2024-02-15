class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :impression

  validates :user_id, uniqueness: {scope: :impression_id}
end
