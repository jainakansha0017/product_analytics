class AddPkProducts < ActiveRecord::Migration
  def change
  	remove_column :products, :id, :integer
    execute "ALTER TABLE products ADD PRIMARY KEY (schemecode);"
  end
end
