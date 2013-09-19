class CreateChaptersAndLeaders < ActiveRecord::Migration
  def change
  	create_table :chapters_leaders do |t|
  		t.belongs_to :leader
  		t.belongs_to :chapter
  	end
  end
end
