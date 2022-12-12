class Playlist < ApplicationRecord
  has_one_attached :image_cover, dependent: :purge

  belongs_to :author, class_name: 'User', foreign_key: :user_id
  has_many :tracks

  before_validation :check_image_cover
  validates :image_cover, attached: true, content_type: %w[image/png image/jpg image/jpeg], size: { less_than: 10.megabytes }
  validates :title, presence: true, length: { minimum: 2, maximum: 40 }

  private

  def check_image_cover
    unless image_cover&.attached?
      image_cover.attach(io: File.open('public/default_image_cover.jpg'), filename: 'default_image_cover.jpg', content_type: 'image/jpg')
    end
  end
end
