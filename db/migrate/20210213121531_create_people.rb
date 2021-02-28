class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.string :name
      t.string :lists, array: true, default: []
      t.timestamps
    end
  end
end
