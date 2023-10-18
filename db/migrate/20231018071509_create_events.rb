class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :detail
      t.string :link, null: false
      t.datetime :start_time
      t.references :user, foreign_key: true
      t.string :tag_list

      t.timestamps
    end
  end
end
