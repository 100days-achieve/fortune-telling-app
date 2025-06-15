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
  user.password = "password123"
  user.password_confirmation = "password123"
end
puts "👑 管理者ユーザーを作成しました: #{admin.email_address}"

# 一般ユーザー
test_users = [
  {
    email_address: "test@example.com",
    password: "password123"
  },
  {
    email_address: "astrology@example.com",
    password: "password123"
  },
  {
    email_address: "numerology@example.com",
    password: "password123"
  },
  {
    email_address: "user1@example.com",
    password: "password123"
  },
  {
    email_address: "user2@example.com",
    password: "password123"
  }
]

test_users.each do |user_data|
  user = User.find_or_create_by!(email_address: user_data[:email_address]) do |user|
    user.password = user_data[:password]
    user.password_confirmation = user_data[:password]
  end
  puts "👤 ユーザーを作成しました: #{user.email_address}"
end

puts "✨ テストユーザーの作成が完了しました！"
