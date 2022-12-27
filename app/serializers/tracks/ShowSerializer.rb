module Tracks
  class ShowSerializer < ActiveModel::Serializer
    include Rails.application.routes.url_helpers

    attributes :id, :title, :image_url, :track_url, :author, :created_at, :updated_at

    def image_url
      return object&.active_image_cover&.url if Rails.env == 'production'

      polymorphic_url(object&.active_image_cover, host: "localhost:3000")
    end

    def track_url
      return object&.track&.url if Rails.env == 'production'

      polymorphic_url(object&.track, host: "localhost:3000")
    end

    belongs_to :playlist
  end
end
