class RemoveBylawsFromChapters < ActiveRecord::Migration
  def up
    remove_column :chapters, :bylaws_file_name
    remove_column :chapters, :bylaws_content_type
    remove_column :chapters, :bylaws_file_size
    remove_column :chapters, :bylaws_updated_at
  end

  def down
    add_column :chapters, :bylaws_updated_at, :string
    add_column :chapters, :bylaws_file_size, :string
    add_column :chapters, :bylaws_content_type, :string
    add_column :chapters, :bylaws_file_name, :string
  end
end
