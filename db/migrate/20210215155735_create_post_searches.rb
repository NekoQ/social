class CreatePostSearches < ActiveRecord::Migration[6.1]
  def change
    create_view :post_searches, materialized: true

    add_index :post_searches, :tsv_document, using: :gin
  end
end
