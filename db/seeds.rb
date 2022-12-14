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
Playlist.destroy_all

user = User.where(email: "test@mail.com", username: "username").first_or_create(email: "test@mail.com", username: "username", password: "password", password_confirmation: "password")
track = Track.where(user_id: user.id).first_or_initialize(author: user, title: "track")
track.track.attach(io: File.open('public/track.mp3'), filename: 'track.mp3', content_type: 'audio/mp3')
track.save

#First playlist with songs
playlist = Playlist.create(title: "First playlist", author: user)
track = Track.create(author: user, playlist: playlist, title: "track2")
track.track.attach(io: File.open('public/track.mp3'), filename: 'track.mp3', content_type: 'audio/mp3')
track.save
track = Track.create(author: user, playlist: playlist, title: "track3")
track.track.attach(io: File.open('public/track.mp3'), filename: 'track.mp3', content_type: 'audio/mp3')
track.save

#Second playlist with songs
playlist = Playlist.create(title: "Second playlist", author: user)
track = Track.create(author: user, playlist: playlist, title: "track3")
track.track.attach(io: File.open('public/track.mp3'), filename: 'track.mp3', content_type: 'audio/mp3')
track.save
track = Track.create(author: user, playlist: playlist, title: "track4")
track.track.attach(io: File.open('public/track.mp3'), filename: 'track.mp3', content_type: 'audio/mp3')
track.save

