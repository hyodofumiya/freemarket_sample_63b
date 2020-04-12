class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, null:false
      t.references :item, null:false, unique:true
      t.references :credit_card, null:false
      t.timestamps
    end
  end
end
