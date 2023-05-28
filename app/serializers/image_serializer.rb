class ImageSerializer < ActiveModel::Serializer
  attributes :id
  has_one_attached :image
  has_one :setting
  has_one :sent_message, serializer: MessageSerializer
  has_one :received_message, serializer: MessageSerializer
end