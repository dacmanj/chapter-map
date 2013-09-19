class AddImportIdsToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :email_1_import_id, :string
    add_column :chapters, :email_2_import_id, :string
    add_column :chapters, :email_3_import_id, :string
    add_column :chapters, :helpline_import_id, :string
    add_column :chapters, :phone_1_import_id, :string
    add_column :chapters, :phone_2_import_id, :string
    add_column :chapters, :address_import_id, :string
  end
end
