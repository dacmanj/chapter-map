class PositionsForChapterLeaers < ActiveRecord::Migration
  def up
    change_table :chapter_leaders do |t|
      t.rename :position_1, :position
      t.rename :spouse_position_1, :spouse_position
      t.string :position_import_id
      t.string :spouse_position_import_id
    end
  end
 
  def down
    change_table :chapter_leaders do |t|
	  t.rename :position_1, :position
      t.rename :spouse_position_1, :spouse_position
      t.remove :position_import_id
      t.remove :spouse_position_import_id
    end
  end
end
 