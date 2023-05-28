class ImageSerializer < ActiveModel::Serializer
  attributes :id, :image_url, :setting

  def image_url
    object.image_url
  end

  def setting
    object.setting
  end
end