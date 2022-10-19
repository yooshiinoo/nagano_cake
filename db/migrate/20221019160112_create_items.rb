class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id,     null: false
      t.integer :customer_id, null: false
      t.text    :introduction, null: false
      t.integer :price,        null: false
      t.boolean :is_active,    null: false, default: true

      t.timestamps
    end
  end
end
