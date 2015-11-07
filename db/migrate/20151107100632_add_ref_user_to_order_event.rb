class AddRefUserToOrderEvent < ActiveRecord::Migration
  def change
    add_reference :order_events, :user, index: true
    add_foreign_key :order_events, :users
  end
end
