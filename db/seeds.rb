# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all
Track.destroy_all

user = User.where(email: "test@mail.com", username: "username").first_or_create(email: "test@mail.com", username: "username", password: "password", password_confirmation: "password")
track = Track.where(author_id: user.id).first_or_initialize(user: user, title: "track")
track.track.attach(io: File.open('public/track.mp3'), filename: 'track.mp3', content_type: 'audio/mp3')
track.save