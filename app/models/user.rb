class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         def self.guest
           find_or_create_by!(email: 'guest@example.com', name: 'guest_user') do |user|
             user.password = SecureRandom.urlsafe_base64
           end
         end

         has_many :impressions, dependent: :destroy
         has_many :comments, dependent: :destroy
         has_many :favorites, dependent: :destroy

         has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
         has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

         has_many :followings, through: :relationships, source: :followed
         has_many :followers, through: :reverse_of_relationships, source: :follower

         has_many :reports, class_name: "Report", foreign_key: "reporter_id", dependent: :destroy
         has_many :reverse_of_reports, class_name: "Report", foreign_key: "reported_id", dependent: :destroy

         validates :name, presence: true
         validates :name, uniqueness: true
         validates :name, length: {maximum: 20}
         validates :email, presence: true
         validates :like_game, length: {maximum: 300}
         validates :introduction, length: {maximum: 300}

         def self.looks(search, word)
          if search == "perfect_match"
            @user = User.where("name LIKE?", "#{word}")
          elsif search == "forward_match"
            @user = User.where("name LIKE?", "#{word}%")
          elsif search == "backward_match"
            @user = User.where("name LIKE?", "%#{word}")
          elsif search == "partial_match"
            @user = User.where("name LIKE?", "%#{word}%")
          else
            @user = User.all
          end
         end

         def follow(user_id)
           relationships.create(followed_id: user_id)
         end

         def unfollow(user_id)
           relationships.find_by(followed_id: user_id).destroy
         end

         def following?(user)
           followings.include?(user)
         end

         def deactivated?
           !is_active
         end
end
