class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         def self.guest
           find_or_create_by!(email: 'guest@example.com', name: 'guesu_user') do |user|
             user.password = SecureRandom.urlsafe_base64
           end
         end

         has_many :impressions, dependent: :destroy
         has_many :comments, dependent: :destroy
         has_many :favorites, dependent: :destroy

         validates :name, presence: true
         validates :email, presence: true

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
end
