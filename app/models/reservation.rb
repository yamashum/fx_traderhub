# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :event
  belongs_to :user
end
