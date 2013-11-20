class DropVoters < ActiveRecord::Migration
  def up
  	drop_table :voters
  	drop_table :ballots
  	drop_table :elections
  	drop_table :items
  	drop_table :votes
  end

  def down
  end
end
