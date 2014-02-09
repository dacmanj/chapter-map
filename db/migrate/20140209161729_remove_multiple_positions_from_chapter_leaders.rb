class RemoveMultiplePositionsFromChapterLeaders < ActiveRecord::Migration
  def up
    change_table :chapter_leaders do |t|
  	  t.remove :position_2
      t.remove :position_3
      t.remove :position_4
      t.remove :position_5
      t.remove :spouse_position_2
      t.remove :spouse_position_3
      t.remove :spouse_position_4
      t.remove :spouse_position_5
	end
  end

  def down
  	change_table :chapter_leaders do |t|
  	  t.string :position_2
      t.string :position_3
      t.string :position_4
      t.string :position_5
      t.string :spouse_position_2
      t.string :spouse_position_3
      t.string :spouse_position_4
      t.string :spouse_position_5
	end
  end
end
