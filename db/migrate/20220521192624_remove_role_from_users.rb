class RemoveRoleFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :roles_id, :integer
    remove_column :users, :role_id, :integer
    remove_reference :users, :role, null: false
  end
end
