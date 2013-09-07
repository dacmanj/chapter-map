class AddSuppressFromDirectoryToLeader < ActiveRecord::Migration
  def change
    add_column :leaders, :suppress_from_directory, :boolean
  end
end
