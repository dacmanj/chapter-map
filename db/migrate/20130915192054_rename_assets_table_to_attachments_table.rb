class RenameAssetsTableToAttachmentsTable < ActiveRecord::Migration
  def up
    rename_table :Assets, :Attachments
  end

  def down
    rename_table :Attachments, :Assets
  end
end
