class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer   :user,          null: false, foreign_key: true
      t.integer   :item,          null: false, foreign_key: true
      t.datetime  :delivary_date, null: false
      t.integer   :credit_id,     null: false
      t.timestamps  
    end
  end
end
