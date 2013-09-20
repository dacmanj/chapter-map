class RenameAssetsTableToAttachmentsTable < ActiveRecord::Migration
  def up
    rename_table :assets, :attachments
  end

  def down
    rename_table :attachments, :assets
  end
end
