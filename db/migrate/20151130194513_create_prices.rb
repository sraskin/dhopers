class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.string :name
      t.integer :dry_cleaning_price
      t.integer :laundry_price

      t.timestamps null: false
    end
  end
end
