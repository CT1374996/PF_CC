class Impression < ApplicationRecord

  with_options presence: true, on: :publicize do
    validates :title
    validates :body
  end

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
