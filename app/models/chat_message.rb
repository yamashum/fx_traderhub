# frozen_string_literal: true

class ChatMessage < ApplicationRecord
  belongs_to :event
  belongs_to :user
end
