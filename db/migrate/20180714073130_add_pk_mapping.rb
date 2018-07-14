class AddPkMapping < ActiveRecord::Migration
  def change
  	remove_column :mappings, :id, :integer
  	execute "ALTER TABLE mappings ADD PRIMARY KEY (user_id,schemecode);"
  end
end
