# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :event_tags, dependent: :destroy
end
