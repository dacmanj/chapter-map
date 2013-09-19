class AddAttributeImportIdsToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :independent_import_id, :string
    add_column :chapters, :ein_import_id, :string
  end
end
