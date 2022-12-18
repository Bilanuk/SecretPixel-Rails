# frozen_string_literal: true

class Track < ApplicationRecord
  has_one_attached :image_cover, dependent: :purge
  has_one_attached :track, dependent: :purge

  belongs_to :author, class_name: 'User', foreign_key: :user_id
  belongs_to :playlist, foreign_key: :playlist_id, optional: true

  before_validation :check_image_cover
  validates :image_cover, content_type: %w[image/png image/jpg image/jpeg], size: { less_than: 10.megabytes }
  validates :track, attached: true, content_type: %w[audio/mp3 audio/mpeg file/mp3], size: {less_than: 20.megabytes}
  validates :title, presence: true, length: {minimum: 2, maximum: 40}

  def active_image_cover
    image_cover.attached? ? image_cover : playlist&.image_cover
  end

  private

  def check_image_cover
    unless image_cover&.attached?
      return if playlist&.image_cover&.attached?

      image_cover.attach(io: File.open('public/default_image_cover.jpg'), filename: 'default_image_cover.jpg', content_type: 'image/jpg')
    end
  end
end
