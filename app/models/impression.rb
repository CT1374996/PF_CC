class Impression < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  enum status: {draft: 0, published: 1, delete: 2, private: 3}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
