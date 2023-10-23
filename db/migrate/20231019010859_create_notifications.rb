# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.text :content
      t.boolean :read
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
