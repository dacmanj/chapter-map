class AddImportIdToMembers < ActiveRecord::Migration
  def change
    add_column :members, :import_id, :string
  end
end
