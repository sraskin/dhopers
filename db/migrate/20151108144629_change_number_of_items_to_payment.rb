class ChangeNumberOfItemsToPayment < ActiveRecord::Migration
  def change
    change_column :payments, :number_of_items, :integer, null: false, default: 1
  end
end
