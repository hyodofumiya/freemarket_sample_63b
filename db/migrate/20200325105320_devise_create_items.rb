# frozen_string_literal: true

class DeviseCreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      ## Database authenticatable
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
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :items, :email,                unique: true
    add_index :items, :reset_password_token, unique: true
    # add_index :items, :confirmation_token,   unique: true
    # add_index :items, :unlock_token,         unique: true
  end
end
