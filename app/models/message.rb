class Message < ApplicationRecord
  belongs_to :user
  belongs_to :image, optional: true

  scope :sent, -> { where(message_type: 'sent') }
  scope :received, -> { where(message_type: 'received') }

  validates :content, presence: true, length: {minimum: 1, maximum: 1000}

  def self.create_sent_message(user, content, image)
    Message.create(user: user, content: content, message_type: 'SENT', image: image)
  end

  def self.create_received_message(user, content, image)
    Message.create(user: user, content: content, message_type: 'RECEIVED', image: image)
  end
end
