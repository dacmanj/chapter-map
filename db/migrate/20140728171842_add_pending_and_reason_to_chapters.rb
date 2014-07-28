class AddPendingAndReasonToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :pending, :boolean
    add_column :chapters, :pending_reason, :string
  end
end
