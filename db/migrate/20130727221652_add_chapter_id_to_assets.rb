class AddChapterIdToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :chapter_id, :integer
  end
end
