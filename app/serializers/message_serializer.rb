class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :message_type
  belongs_to :user
  belongs_to :image
end