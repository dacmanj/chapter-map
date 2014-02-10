class AddPositionLockToChapter < ActiveRecord::Migration
  def change
    add_column :chapters, :position_lock, :boolean
  end
end
