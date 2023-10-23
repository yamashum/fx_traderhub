# frozen_string_literal: true

class CreateBulletinChats < ActiveRecord::Migration[5.2]
  def change
    create_table :bulletin_chats do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :bulletin, foreign_key: true

      t.timestamps
    end
  end
end
