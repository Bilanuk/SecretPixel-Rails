User.destroy_all

user = User.create(email: "romanbilanuk@gmail.com", username: "BiLaNuK", password: "12345678", password_confirmation: "12345678")

# Add images
image1 = user.images.create(name: "Image 1")
image1.file.attach(io: File.open("./public/moon.png"), filename: "moon.png")
