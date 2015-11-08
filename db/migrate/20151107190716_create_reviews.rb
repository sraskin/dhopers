class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :order, index: true
      t.references :user, index: true
      t.integer :rate
      t.string :comments
      t.integer :reviewed_by_id
      t.integer :reviewed_on

      t.timestamps null: false
    end
    add_index :reviews, :reviewed_by_id
    add_foreign_key :reviews, :orders
    add_foreign_key :reviews, :users
  end
end
