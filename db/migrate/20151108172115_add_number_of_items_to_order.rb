class AddNumberOfItemsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :item_count, :integer, default: 1, null: false
  end
end
