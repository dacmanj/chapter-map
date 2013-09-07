class CreateChapterLeaders < ActiveRecord::Migration
  def change
    create_table :chapter_leaders do |t|
      t.integer :chapter_id
      t.integer :leader_id
      t.string :position_1
      t.string :position_2
      t.string :position_3
      t.string :position_4
      t.string :position_5
      t.string :spouse_position_1
      t.string :spouse_position_2
      t.string :spouse_position_3
      t.string :spouse_position_4
      t.string :spouse_position_5

      t.timestamps
    end
  end
end
