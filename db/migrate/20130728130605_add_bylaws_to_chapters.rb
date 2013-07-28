class AddBylawsToChapters < ActiveRecord::Migration
 def self.up
    add_attachment :chapters, :bylaws
  end

  def self.down
    remove_attachment :chapters, :bylaws
  end
end
