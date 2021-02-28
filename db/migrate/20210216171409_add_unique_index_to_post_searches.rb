class AddUniqueIndexToPostSearches < ActiveRecord::Migration[6.1]
  def change
    add_index :post_searches, :post_id, unique: true
  end
end
