# frozen_string_literal: true

class BulletinChat < ApplicationRecord
  belongs_to :user
  belongs_to :bulletin
end
