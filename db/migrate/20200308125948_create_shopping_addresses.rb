class CreateShoppingAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :shopping_addresses do |t|
      t.string :family_name, null:false
      t.string :first_name, null:false
      t.string :family_name_kana, null:false
      t.string :first_name_kana, null:false
      t.string :post_cord, null:false
      t.string :prefecture, null:false
      t.string :cities, null:false
      t.string :address, null:false
      t.string :building_name, null:false,  default: ""
      t.string :phone_number
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
