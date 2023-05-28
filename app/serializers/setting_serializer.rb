class SettingSerializer < ActiveModel::Serializer
  attributes :id, :color, :method
  belongs_to :user
  belongs_to :image
end