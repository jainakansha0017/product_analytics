class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :schemecode
      t.string :s_name
      t.integer :rating
      t.string :category
      t.text :objective
      t.timestamps null: false
    end
  end
end
