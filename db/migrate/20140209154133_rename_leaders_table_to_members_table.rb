class RenameLeadersTableToMembersTable < ActiveRecord::Migration
    def self.up
        rename_table :leaders, :members
    end 
    def self.down
        rename_table :members, :leaders
    end
end
