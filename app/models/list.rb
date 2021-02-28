class List < ApplicationRecord

    def add_people(array)
        array.each do |name|
            p = Person.find_by(name: name)
            p.lists.append(self.name)
            p.save
        end
        people.concat array
        self.save
    end
end
