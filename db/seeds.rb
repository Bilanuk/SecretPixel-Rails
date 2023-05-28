Image.destroy_all
User.destroy_all

user = User.create(email: "romanbilanuk@gmail.com", username: "BiLaNuK", password: "12345678", password_confirmation: "12345678")

# Add images
image1 = user.images.create(name: "Image 1")
image1.file.attach(io: File.open("./public/moon.bmp"), filename: "moon.bmp")

image2 = user.images.create(name: "Image 2")
image2.file.attach(io: File.open("./public/stairs.bmp"), filename: "stairs.bmp")

image3 = user.images.create(name: "Image 3")
image3.file.attach(io: File.open("./public/wall.bmp"), filename: "wall.bmp")

image4 = user.images.create(name: "Image 4")
image4.file.attach(io: File.open("./public/moon.bmp"), filename: "moon.bmp")