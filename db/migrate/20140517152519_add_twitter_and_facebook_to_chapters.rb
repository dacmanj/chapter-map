class AddTwitterAndFacebookToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :twitter_url, :string
    add_column :chapters, :twitter_url_import_id, :string
    add_column :chapters, :facebook_url, :string
    add_column :chapters, :facebook_url_import_id, :string
  end
end
