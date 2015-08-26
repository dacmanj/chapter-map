class AddMeetingFlagsToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :meetings_trans, :boolean
    add_column :chapters, :meetings_multiple, :boolean
    add_column :chapters, :meetings_poc, :boolean
    add_column :chapters, :meetings_url, :string
    add_column :chapters, :meetings_trans_import_id, :string
    add_column :chapters, :meetings_multiple_import_id, :string
    add_column :chapters, :meetings_poc_import_id, :string  
    add_column :chapters, :meetings_url_import_id, :string
  end
end