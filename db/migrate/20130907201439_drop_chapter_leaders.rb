class DropChapterLeaders < ActiveRecord::Migration
  def up
  	drop_table :chapters_leaders
  end

  def down
  end
end
