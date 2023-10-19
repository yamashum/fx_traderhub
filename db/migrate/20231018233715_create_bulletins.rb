class CreateBulletins < ActiveRecord::Migration[5.2]
  def change
    create_table :bulletins do |t|
      t.string :title, null: false
      t.text :content
      t.references :user, foreign_key: true
      t.string :new_attributes
      t.string :image

      t.timestamps
    end
  end
end
