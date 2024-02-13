class Impression < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def self.search(search)
    return Impression.all unless search
    Impression.where(['title LIKE(?) OR body LIKE(?)', "%#{search}", "%#{search}"])
  end
end
