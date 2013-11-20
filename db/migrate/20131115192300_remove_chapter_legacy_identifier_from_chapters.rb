class RemoveChapterLegacyIdentifierFromChapters < ActiveRecord::Migration
  def up
    remove_column :chapters, :chapter_legacy_identifier
  end

  def down
    add_column :chapters, :chapter_legacy_identifier, :string
  end
end
