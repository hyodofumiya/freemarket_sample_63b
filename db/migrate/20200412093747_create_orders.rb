class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user
      t.references :item
      t.references :credit_card
      t.timestamps
    end
  end
end
