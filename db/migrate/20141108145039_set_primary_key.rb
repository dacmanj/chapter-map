class SetPrimaryKey < ActiveRecord::Migration
  def change
   execute "ALTER TABLE members ADD PRIMARY KEY (id);"
  end
end

