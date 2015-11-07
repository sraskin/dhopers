class CreateOrderEvents < ActiveRecord::Migration
  def change
    create_table :order_events do |t|
      t.string :previous_state
      t.string :current_state
      t.references :order, index: true
      t.string :notes

      t.timestamps null: false
    end
    add_foreign_key :order_events, :orders
  end
end
