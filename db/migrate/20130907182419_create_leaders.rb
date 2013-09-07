class CreateLeaders < ActiveRecord::Migration
  def change
    create_table :leaders do |t|
      t.string :contituent_id
      t.string :first_name
      t.string :last_name
      t.string :chapter_code
      t.string :position_1
      t.string :position_2
      t.string :position_3
      t.string :position_4
      t.string :position_5
      t.string :spouse_first_name
      t.string :spouse_last_name
      t.string :spouse_position_1
      t.string :spouse_position_2
      t.string :spouse_position_3
      t.string :spouse_position_4
      t.string :spouse_position_5
      t.string :address
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :email
      t.string :address_import_id
      t.string :phone_import_id
      t.string :email_import_id

      t.timestamps
    end
  end
end
