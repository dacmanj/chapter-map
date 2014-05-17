class AddWebsiteImportIdToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :website_import_id, :string
  end
end
