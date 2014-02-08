class AddOverrideToUsers < ActiveRecord::Migration
  def change
    add_column :users, :override_sync, :boolean
  end
end
