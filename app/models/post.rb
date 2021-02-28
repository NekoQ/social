class PostSearch < ApplicationRecord
    self.primary_key = :post_id

    include PgSearch::Model
    pg_search_scope(
        :search, 
        against: :tsv_document,
        using: {
        tsearch: {
            dictionary: "english",
            tsvector_column: "tsv_document",
            },
        },
    )

    def self.refresh_materialized_view
        Scenic.database.refresh_materialized_view(
            :post_searches,
            concurrently: true,
        )
    end
end

class Post < ApplicationRecord
    belongs_to :person
    validates :date, presence: true
    validates :link, presence: true
    validates :link, presence: true
    validates :text, presence: true

    def self.fast_search(query)
        where(id: PostSearch.search(query).select(:post_id))
    end

    def self.filtered_by_lists(lists)
        if lists
            people_ids = []
            Person.filtered_by_lists(lists).each do |person|
                people_ids.append(person.id)
            end

            self.where("person_id in (?)", people_ids)
        else
            self.all
        end
    end

    def self.filtered_by_network(networks)
        if networks
            self.where("network in (?)", networks)
        else
            self.all
        end
    end

    def self.filtered_by_date(start_date, end_date)
        if start_date == ''
            start_date = nil
        end
        if end_date == ''
            end_date = nil
        end
        if (start_date && end_date)
            self.where('date between ? and ?', start_date, end_date)
        else
            self.all
        end
    end

end
