class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username

  has_one :setting
  has_many :images
  has_many :sent_messages
  has_many :received_messages
end
