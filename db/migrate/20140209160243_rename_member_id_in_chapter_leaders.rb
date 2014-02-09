class RenameMemberIdInChapterLeaders < ActiveRecord::Migration
  def up
	rename_column :chapter_leaders, :leader_id, :member_id
  end

  def down
	rename_column :chapter_leaders, :member_id, :leader_id
  end
end
