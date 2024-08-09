class Impression < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :notifications, dependent: :destroy

  validates :title, presence: true, length: {maximum: 30}
  validates :body, presence: true, length: {maximum: 5000}

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

  def create_notification_like!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and impression_id = ? and action = ?", current_user.id, user_id, id, "favorite"])
    if temp.blank?
      notification = current_user.active_notifications.new(
        impression_id: id,
        visited_id: user_id,
        action: "favorite"
        )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      if notification.valid?
        notification.save
        puts "Notification has been created."
      else
        puts "Notification is invalid. Error messages: #{notification.errors.full_messages.join(',')}"
      end
    else
      puts "Notification already exists."
    end
  end

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(impression_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id["user_id"])
    end
    save_notification_comment!(current_user, comment_id, user_id)
    if temp_ids.blank?
    end
  end

  def save_notification_comment!(current_user, comment_id, visitor_id)
    notification = current_user.active_notifications.new(
      impression_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: "comment"
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
  end
end
