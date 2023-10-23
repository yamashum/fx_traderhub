# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :bulletin
  validates_uniqueness_of :bulletin_id, scope: :user_id
end
