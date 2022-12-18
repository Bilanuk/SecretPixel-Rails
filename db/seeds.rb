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

user = User.create(email: "romanbilanuk@gmail.com", username: "BiLaNuK", password: "12345678", password_confirmation: "12345678")
track = Track.new(author: user, title: "track")
track.track.attach(io: File.open('public/track.mp3'), filename: 'track.mp3', content_type: 'audio/mp3')
track.save!

#First playlist with songs
playlist = Playlist.new(title: "ChillOut", author: user)
playlist.image_cover.attach(io: File.open('public/chillout.jpg'), filename: 'chillout.jpg', content_type: 'image/jpg')
playlist.save!
track = Track.new(author: user, playlist: playlist, title: "Moon")
track.track.attach(io: File.open('public/moon.mp3'), filename: 'moon.mp3', content_type: 'audio/mp3')
track.image_cover.attach(io: File.open('public/moon.png'), filename: 'moon.png', content_type: 'image/png')
track.save!
track = Track.new(author: user, playlist: playlist, title: "Snowfall")
track.track.attach(io: File.open('public/snowfall.mp3'), filename: 'snowfall.mp3', content_type: 'audio/mp3')
track.save!
track = Track.new(author: user, playlist: playlist, title: "Virgo")
track.track.attach(io: File.open('public/Virgo.mp3'), filename: 'Virgo.mp3', content_type: 'audio/mp3')
track.save!
track = Track.new(author: user, playlist: playlist, title: "letter to jarad")
track.track.attach(io: File.open('public/letter to jarad.mp3'), filename: 'letter to jarad.mp3', content_type: 'audio/mp3')
track.save!


#Second playlist with songs
playlist = Playlist.new(title: "Hip-hop", author: user)
playlist.image_cover.attach(io: File.open('public/6obby.jpg'), filename: '6obby.jpg', content_type: 'image/jpg')
playlist.save!
track = Track.new(author: user, playlist: playlist, title: "miss me")
track.track.attach(io: File.open('public/6obby - miss me.mp3'), filename: '6obby - miss me.mp3', content_type: 'audio/mp3')
track.save!
track = Track.new(author: user, playlist: playlist, title: "feed me to the wolves")
track.track.attach(io: File.open('public/6obby - feed me to the wolves.mp3'), filename: '6obby - feed me to the wolves.mp3', content_type: 'audio/mp3')
track.save!
track = Track.new(author: user, playlist: playlist, title: "Princess Bride")
track.track.attach(io: File.open('public/40rtycal - Princess Bride.mp3'), filename: '40rtycal - Princess Bride.mp3', content_type: 'audio/mp3')
track.save!


