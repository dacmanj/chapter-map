class RemoveIdentity < ActiveRecord::Migration
  def change
  	drop_table :identities
  end
end
