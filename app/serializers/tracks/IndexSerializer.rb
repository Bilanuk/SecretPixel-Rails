module Tracks
  class IndexSerializer < ActiveModel::Serializer
    include Rails.application.routes.url_helpers

    attributes :id, :title, :image_url

    def image_url
      return object&.image_cover&.url if Rails.env == 'production'

      polymorphic_url(object.image_cover, host: "localhost:3000")
    end
  end
end
