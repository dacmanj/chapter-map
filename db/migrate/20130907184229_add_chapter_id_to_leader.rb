class AddChapterIdToLeader < ActiveRecord::Migration
  def change
    add_column :leaders, :chapter_id, :integer
  end
end
