class RemoveActivationCodeFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :activation_code
  end

  def down
    add_column :users, :activation_code, :string
  end
end
