class Image < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  has_one_attached :file
  has_one :setting, dependent: :destroy

  accepts_nested_attributes_for :setting

  after_create :create_setting

  def create_setting
    build_setting(color: 'na', method: 'na')
    setting.save
  end

  def image_url
    return self&.file&.url if Rails.env == 'production'

    polymorphic_url(self&.file, host: "localhost:3000")
  end
end
