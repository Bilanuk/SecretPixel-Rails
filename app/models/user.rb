# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable

  validates :email, presence: true, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
  validates :username, presence: true, length: {minimum: 3, maximum: 25}, format: {with: /\A[a-zA-Z0-9]+\z/}

  api_guard_associations refresh_token: "refresh_tokens", blacklisted_token: "blacklisted_tokens"

  has_many :refresh_tokens, dependent: :delete_all
  has_many :blacklisted_tokens, dependent: :delete_all
  has_one :setting, dependent: :delete
  accepts_nested_attributes_for :setting
  has_many :images, dependent: :delete_all
  has_many :sent_messages, -> { sent }, class_name: 'Message', dependent: :delete_all
  has_many :received_messages, -> { received }, class_name: 'Message', dependent: :delete_all

  def authenticate(password)
    valid_password?(password)
  end
end
