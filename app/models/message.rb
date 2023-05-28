class Message < ApplicationRecord
  belongs_to :user
  belongs_to :image, optional: true

  enum message_type: {
    sent: 'SENT',
    received: 'RECEIVED'
  }

  scope :sent, -> { where(message_type: 'sent') }
  scope :received, -> { where(message_type: 'received') }

  validates :content, presence: true, length: { minimum: 1, maximum: 100 }
  validates :message_type, inclusion: { in: %w[sent received] }

  def self.create_sent_message(user, content, image)
    Message.create(user: user, content: content, message_type: :sent, image: image)
  end

  def self.create_received_message(user, content, image)
    Message.create(user: user, content: content, message_type: :received, image: image)
  end
end
