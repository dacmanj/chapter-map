class AddTagToAsset < ActiveRecord::Migration
  def change
    add_column :assets, :tag, :string
  end
end
