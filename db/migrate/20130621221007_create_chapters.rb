class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :name
      t.string :website
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :email_1
      t.string :email_2
      t.string :email_3
      t.string :helpline
      t.string :phone_1
      t.string :phone_2
      t.float :latitude
      t.float :longitude
      t.string :ein

      t.timestamps
    end
  end
end
