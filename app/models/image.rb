class Image < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  has_one :setting
  has_one :sent_message, class_name: 'Message', foreign_key: 'sent_image_id'
  has_one :received_message, class_name: 'Message', foreign_key: 'received_image_id'
end
