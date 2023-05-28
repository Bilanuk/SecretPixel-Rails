class ImageSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :image_url
 
  has_one :setting
  has_one :sent_message, serializer: MessageSerializer
  has_one :received_message, serializer: MessageSerializer

  def image_url
    return object&.file&.url if Rails.env == 'production'

    polymorphic_url(object&.file, host: "localhost:3000")
  end
end