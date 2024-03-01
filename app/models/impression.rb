class Impression < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @impression = Impression.where("title LIkE?", "#{word}")
    elsif search == "forward_match"
      @impression = Impression.where("title LikE?", "#{word}%")
    elsif search == "backward_match"
      @impression = Impression.where("title LIKE?", "%#{word}")
    elsif search == "pertial_match"
      @impression = Impression.where("title LIKE?", "%#{word}%")
    else
      @impression = Impression.all
    end
  end
end
