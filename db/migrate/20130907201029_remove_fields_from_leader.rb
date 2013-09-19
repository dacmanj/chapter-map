class RemoveFieldsFromLeader < ActiveRecord::Migration
  def up
    remove_column :leaders, :position_1
    remove_column :leaders, :position_2
    remove_column :leaders, :position_3
    remove_column :leaders, :position_4
    remove_column :leaders, :position_5
    remove_column :leaders, :spouse_position_1
    remove_column :leaders, :spouse_position_2
    remove_column :leaders, :spouse_position_3
    remove_column :leaders, :spouse_position_4
    remove_column :leaders, :spouse_position_5
  end

  def down
    add_column :leaders, :spouse_position_5, :string
    add_column :leaders, :spouse_position_4, :string
    add_column :leaders, :spouse_position_3, :string
    add_column :leaders, :spouse_position_2, :string
    add_column :leaders, :spouse_position_1, :string
    add_column :leaders, :position_5, :string
    add_column :leaders, :position_4, :string
    add_column :leaders, :position_3, :string
    add_column :leaders, :position_2, :string
    add_column :leaders, :position_1, :string
  end
end
