# frozen_string_literal: true

class Track < ApplicationRecord
  has_one_attached :track, dependent: :purge

  belongs_to :user, foreign_key: :author_id

  validates :track, attached: true, content_type: %w[audio/mp3 audio/mpeg file/mp3], size: {less_than: 20.megabytes}
  validates :title, presence: true, length: {minimum: 2, maximum: 40}

  def track_url
    track&.url
  end
end
