class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :order_id
      t.boolean :due
      t.float :amount
      t.string :notes
      t.integer :collected_by_id
      t.string :number_of_items
      t.float :discount
      t.float :final_price
      t.integer :reviewed_by_id

      t.timestamps null: false
    end
    add_index :payments, :order_id
    add_index :payments, :collected_by_id
    add_index :payments, :reviewed_by_id
  end
end
