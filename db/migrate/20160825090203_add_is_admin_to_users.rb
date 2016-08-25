class AddIsAdminToUsers < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :is_admin, :boolean, default: false, null: false
  end

  def down
    remove_column :users, :is_admin
  end
end
