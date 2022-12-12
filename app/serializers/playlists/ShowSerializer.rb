module Playlists
  class ShowSerializer < ActiveModel::Serializer
    include Rails.application.routes.url_helpers

    attributes :id, :title, :image_url

    def image_url
      return object&.image_cover&.url if Rails.env == 'production'

      polymorphic_url(object.image_cover, host: "localhost:3000")
    end

    belongs_to :author
    has_many :tracks
  end
end
