class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :impression

  validates :comment, length: {maximum: 300}
end
