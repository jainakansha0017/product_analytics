class CreateMappings < ActiveRecord::Migration
  def change
    create_table :mappings do |t|
      t.integer :user_id
      t.integer :schemecode
      t.integer :clicks
      t.timestamps null: false
    end
  end
end
