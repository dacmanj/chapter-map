class AddChapterIdsToChapter < ActiveRecord::Migration
  def change
    add_column :chapters, :database_identifier, :string
    add_column :chapters, :chapter_legacy_identifier, :string
  end
end
