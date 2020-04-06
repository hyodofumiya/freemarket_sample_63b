class AddDefaultStatusToItem < ActiveRecord::Migration[5.2]
  def up
    change_column :items, :status, :boolean, default: true
  end

  def down
    change_column :items, :status, :boolean
  end
end
