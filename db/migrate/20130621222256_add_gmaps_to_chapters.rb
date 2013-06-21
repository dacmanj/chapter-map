class AddGmapsToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :gmaps, :boolean
  end
end
