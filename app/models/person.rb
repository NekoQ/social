class Person < ApplicationRecord
    has_many :posts
    

    def self.filtered_by_lists(tags)
        people = []
        Person.all.each do |person|
            present = true
            tags.each do |tag|
                unless person.lists.include? tag
                    present = false
                end
            end
            if present
                people.append(person.name)
            end
        end
        Person.where('name in (?)', people)
    end

end
