class AddFieldsToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :separate_exemption, :boolean
    add_column :chapters, :inactive, :boolean
  end
end
