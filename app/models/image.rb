class Image < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  has_one :setting, dependent: :destroy
  accepts_nested_attributes_for :setting
  has_one :sent_message, class_name: 'Message'
  has_one :received_message, class_name: 'Message'
end
