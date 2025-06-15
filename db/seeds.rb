# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# テストユーザーの作成
puts "🌟 テストユーザーを作成中..."

# 管理者ユーザー
admin = User.find_or_create_by!(email_address: "admin@example.com") do |user|
  user.password = "password"
end
puts "👑 管理者ユーザーを作成しました: #{admin.email_address}"

# 一般ユーザー
test_users = [
  { email: "test@example.com", name: "テストユーザー" },
  { email: "astrology@example.com", name: "星座占い好き" },
  { email: "numerology@example.com", name: "数秘術研究者" },
  { email: "user1@example.com", name: "一般ユーザー1" },
  { email: "user2@example.com", name: "一般ユーザー2" }
]

test_users.each do |user_data|
  user = User.find_or_create_by!(email_address: user_data[:email]) do |u|
    u.password = "password"
  end
  puts "👤 ユーザーを作成しました: #{user.email_address}"
end

puts "🎉 シードデータの作成が完了しました！"
puts "📊 総ユーザー数: #{User.count}"
