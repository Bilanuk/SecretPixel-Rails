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
image1.sent_message = sent_message1
image1.save

sent_message2 = user.sent_messages.create(content: "Sent message 2", message_type: "sent")
image2.save

# Add received messages
received_message1 = user.received_messages.create(content: "Received message 1", message_type: "received")
image1.save

received_message2 = user.received_messages.create(content: "Received message 2", message_type: "received")
image2.received_message = received_message2
image2.save
