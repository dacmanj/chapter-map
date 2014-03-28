class AddAmbiguateToChapter < ActiveRecord::Migration
  def change
    add_column :chapters, :ambiguate_address, :boolean
  end
end
