# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :image,               null: false
      t.text :discription,           null: false
      t.integer  :category_id,       null: false
      t.integer  :condition,       null: false
      t.integer  :delivary_fee,       null: false
      t.integer  :area,       null: false
      t.integer  :preparation_day,       null: false
      t.integer  :price,       null: false
      t.boolean  :status,       null: false
  
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      t.integer  :size
      t.integer  :bland_id

      ## Recoverable

      ## Rememberable
      t.datetime :remember_created_at


      t.timestamps null: false
    end

    add_index :items, :email,                unique: true
  end
end