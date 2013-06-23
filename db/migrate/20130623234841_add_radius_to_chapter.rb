class AddRadiusToChapter < ActiveRecord::Migration
  def change
    add_column :chapters, :radius, :integer
  end
end
