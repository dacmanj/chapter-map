class AddFileToAssets < ActiveRecord::Migration
  def self.up
    add_attachment :assets, :attachment
  end

  def self.down
    remove_attachment :assets, :attachment
  end
end
