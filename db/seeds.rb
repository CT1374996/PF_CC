Admin.create!(
  email: 'a@a',
  password: '000000'
)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

code = User.find_or_create_by!(email: "cd@vn") do |user|
  user.name = "code"
  user.password = "212121"
  user.like_game = "RPG、アクション等"
  user.introduction = "よろしくね"
end

kinakopurin = User.find_or_create_by!(email: "mz@kp") do |user|
  user.name = "きなこプリン"
  user.password = "454545"
  user.like_game = "リズムゲーム全般"
  user.introduction = "ひらめきプリン～☆"
end

stars = User.find_or_create_by!(email: "vio@hzd") do |user|
  user.name = "stars"
  user.password = "password"
  user.like_game = "ホラー"
  user.introduction = "泣けるぜ"
end

Impression.find_or_create_by!(title: "ゲームの感想") do |impression|
  impression.body = "先日クリアしたゲーム『魂王』の感想を書きます。(以下省略)"
  impression.user = code
end

Impression.find_or_create_by!(title: "シナリオ考察") do |impression|
  impression.body = "七音偶像というゲームについての考察です。(以下省略)"
  impression.user = kinakopurin
end

Impression.find_or_create_by!(title: "思い出話") do |impression|
  impression.body = "子供の頃に遊んだ思い出のゲーム『たぬきまち☆パニック』について語ります。(以下省略)"
  impression.user = stars
end