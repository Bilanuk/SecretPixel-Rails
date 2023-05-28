class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :type
  belongs_to :user
  belongs_to :image
end