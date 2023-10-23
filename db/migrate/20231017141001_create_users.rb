# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :nickname, null: false
      t.string :email, null: false
      t.string :icon_image
      t.string :self_introduction
      t.string :password_digest

      t.timestamps
    end
  end
end
