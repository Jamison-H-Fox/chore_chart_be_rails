class CreateLootItems < ActiveRecord::Migration[8.1]
  def change
    create_table :loot_items do |t|
      t.string :name,       null: false
      t.string :collection, null: false
      t.string :rarity,     null: false
      t.string :image_url,  null: false
      t.timestamps null: false
    end

    add_index :loot_items, :rarity
    add_index :loot_items, [ :name, :rarity ], unique: true
  end
end
