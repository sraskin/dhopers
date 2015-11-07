class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true
      t.integer :order_number
      t.string :aasm_state
      t.string :notes
      t.float :amount
      t.integer :vat
      t.integer :order_receiver_id
      t.boolean :cr
      t.datetime :requested_at

      t.timestamps null: false
    end
    add_index :orders, :order_receiver_id
    add_foreign_key :orders, :users
  end
end
