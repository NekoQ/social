
networks = ['Facebook', 'Twitter', 'Linkedin']
networks.each do |network|
    Network.create(name: network)
end

lists = ['important', 'ruby', 'rails', 'useful', 'api', 'backend', 'frontend']
lists.each do |list|
    List.create(name: list)
end

names = ['Kaci Magana', 'Efe Solis', 'Saba Barnard', 'Marcelina Hudson', 'Arissa King', 'Shanice Croft', 'Shelby Todd', 'Maariya Butler', 'Devin Castro', 'Elysia Wade', 'Layla-Mae Bell', 'Michaela Blair', 'Chloe-Ann Liu', 'Ira Cowan', 'Kathy Braun', 'Beatrice Mac', 'Ailsa Palmer', 'Anastasia Reeve', 'Jasmine Stubbs', 'Malaika Webster', 'Lily Stevenson', 'Ciara Vincent', 'Faisal Castro', 'Lina Caldwell', 'Rupert Kane', 'Caelan Macdonald', 'Ephraim Stacey', 'Raees Magana', 'Chaya Barton', 'Lilah Flowers']
words = 'end general statement sun different scale iron pause arithmetic earthquake terrible fail certain rambunctious dispensable sleep handle hard-to-find label march quack hurried smell corn descriptive hall amazing compare conscious trade nail imagine kettle intend cemetery strange humorous harass giddy children dead men chalk basketball wait deranged question line tawdry appreciate good'.split

(0..1000).each do |i|
    name = names.sample
    if Person.find_by(name: name)
        person = Person.find_by(name: name)
    else
        person = Person.create(name: name)
    end

    person.posts.create(date: '2021-'+rand(1..12).to_s+'-'+rand(1..28).to_s, link: 'https://www.google.com/', network: networks.sample, author_name: name, text: words.sample(5).join(' '))
end

List.all.each do |list|
    list.add_people(names.sample(2))
end

PostSearch.refresh_materialized_view
