# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user
  has_many :event_tags, dependent: :destroy
  has_many :tags, through: :event_tags
  has_many :reservations, dependent: :destroy
  has_many :chat_messages, dependent: :destroy
end
