class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :discription
      t.integer :size
      t.integer :condition, null: false
      t.integer :delivary, null: false
      t.integer :area, null: false
      t.integer :preparation_day, null: false
      t.integer :price, null: false
      t.boolean :status, null: false
      t.references :user
      t.references :brand

      t.timestamps
    end
  end
end