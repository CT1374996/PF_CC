class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :impression
  has_many :notifications, dependent: :destroy

  validates :comment, length: {maximum: 300}
end
