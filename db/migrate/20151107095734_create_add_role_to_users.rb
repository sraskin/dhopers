class CreateAddRoleToUsers < ActiveRecord::Migration
  def change
    create_table :add_role_to_users do |t|
      t.integer :role, null: false, default: 0

      t.timestamps null: false
    end
  end
end
