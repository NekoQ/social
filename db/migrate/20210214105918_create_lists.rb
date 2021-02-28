class CreateLists < ActiveRecord::Migration[6.1]
  def change
    create_table :lists do |t|
      t.string :name
      t.string :people, array: true, default: []
      
      t.timestamps
    end
    add_index :lists, :name, unique: true
  end
end
