# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all

user = User.create(email: "romanbilanuk@gmail.com", username: "BiLaNuK", password: "12345678", password_confirmation: "12345678")

# Add images
image1 = user.images.create
image1.file.attach(io: File.open("./public/moon.png"), filename: "moon.png")
image2 = user.images.create
image2.file.attach(io: File.open("./public/moon.png"), filename: "moon.png")

# Add setting
setting = user.create_setting(color: "red_blue", method: "snowflake")

# Add sent messages
sent_message1 = user.sent_messages.create(content: "Sent message 1", message_type: "sent")
sent_message2 = user.sent_messages.create(content: "Sent message 2", message_type: "sent")

# Add received messages
received_message1 = user.received_messages.create(content: "Received message 1", message_type: "received")
received_message2 = user.received_messages.create(content: "Received message 2", message_type: "received")
