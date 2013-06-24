class AddCategoryToChapter < ActiveRecord::Migration
  def change
    add_column :chapters, :category, :string
  end
end
