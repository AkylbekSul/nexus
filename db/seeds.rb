# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "faker"

case Rails.env
when "development"
  User.create!(username: "Akylbek", email: "abdutalipovich.s@gmail.com", password: "foobar123", password_confirmation: "foobar123")

  100.times do
    User.create!(username: Faker::Name.first_name, email: Faker::Internet.unique.email, password: "password", password_confirmation: "password")
  end
when "production"
end