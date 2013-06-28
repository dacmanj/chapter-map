class CreateChaptersAndUsers < ActiveRecord::Migration
  def change

    create_table :chapters_users do |t|
      t.belongs_to :chapter
      t.belongs_to :user
    end

  end
end
