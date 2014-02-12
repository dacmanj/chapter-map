class RemoveAddress2FromMembers < ActiveRecord::Migration
  def up
    remove_column :members, :address_2
  end

  def down
    add_column :members, :address_2, :string
  end
end
