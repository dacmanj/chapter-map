class AddGmapsAddressToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :gmaps_address, :string
  end
end
