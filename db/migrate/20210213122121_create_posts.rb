class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.date :date
      t.string :network
      t.string :link
      t.string :author_name
      t.belongs_to :person, null: false, foreign_key: true
      t.text :text

      t.timestamps
    end
  end
end
