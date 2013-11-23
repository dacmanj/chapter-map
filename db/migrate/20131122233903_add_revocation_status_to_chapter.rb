class AddRevocationStatusToChapter < ActiveRecord::Migration
  def change
    add_column :chapters, :revoked, :boolean
    add_column :chapters, :revocation_date, :date
  end
end
