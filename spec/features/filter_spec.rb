require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation

RSpec.describe "Index features:" do
    it 'list all posts' do
        DatabaseCleaner.clean
        person = Person.create(name: 'Test Name')
        post = Post.create!(
            date: '2021-02-28',
            network: 'Facebook',
            link: 'https://google.com',
            person: person,
            text: 'Sample text'
        )
        visit('/posts')

        within('.author_name') do
            expect(page).to have_content(person.name)
        end
        within('.network') do
            expect(page).to have_content(post.network)
        end
        within('.date') do
            expect(page).to have_content(post.date)
        end
        within('.text') do
            expect(page).to have_content(post.text)
        end
    end

    it 'filter by lists' do
        DatabaseCleaner.clean
        person = Person.create(name: 'Name', lists: ['api'])
        post = Post.create!(
            date: DateTime.now,
            network: 'Facebook',
            link: 'https://google.com',
            person: person,
            text: 'Sample text'
        )
        person2 = Person.create(name: 'Test', lists: ['ruby'])
        post2 = Post.create!(
            date: DateTime.now,
            network: 'Facebook',
            link: 'https://google.com',
            person: person2,
            text: 'Sample text'
        )

        visit('/posts?&lists%5B%5D=api')

        within('.tag') do
            expect(page).to have_content('api')
            expect(page).to_not have_content('ruby')
        end
    end

    it 'filter by networks' do 
        DatabaseCleaner.clean
        person = Person.create(name: 'Name', lists: ['api'])
        post = Post.create!(
            date: DateTime.now,
            network: 'Twitter',
            link: 'https://google.com',
            person: person,
            text: 'Sample text'
        )
        person2 = Person.create(name: 'Name', lists: ['api'])
        post2 = Post.create!(
            date: DateTime.now,
            network: 'Facebook',
            link: 'https://google.com',
            person: person2,
            text: 'Sample text'
        )

        visit('/posts?networks%5B%5D=Twitter')

        within('.network') do
            expect(page).to have_content('Twitter')
            expect(page).to_not have_content('Facebook')
        end
    end

    it 'filter by date' do 
        DatabaseCleaner.clean
        person = Person.create(name: 'Name', lists: ['api'])
        post = Post.create!(
            date: '1955-02-16',
            network: 'Twitter',
            link: 'https://google.com',
            person: person,
            text: 'Sample text'
        )
        person2 = Person.create(name: 'Name', lists: ['api'])
        post2 = Post.create!(
            date: '2021-02-17',
            network: 'Facebook',
            link: 'https://google.com',
            person: person2,
            text: 'Sample text'
        )

        visit('/posts?start_date=1955-02-16&end_date=1955-02-16')

        within('.date') do
            expect(page).to have_content(post.date)
            expect(page).to_not have_content(post2.date)
        end
    end

    it 'search by content' do
        DatabaseCleaner.clean
        person = Person.create(name: 'Name', lists: ['api'])
        post = Post.create!(
            date: '1955-02-16',
            network: 'Twitter',
            link: 'https://google.com',
            person: person,
            text: 'This is sample text'
        )
        person2 = Person.create(name: 'Name', lists: ['api'])
        post2 = Post.create!(
            date: '2021-02-17',
            network: 'Facebook',
            link: 'https://google.com',
            person: person2,
            text: 'Words with no meaning'
        )
        PostSearch.refresh_materialized_view

        visit('/posts?search_text=sample+text')

        within('.text') do
            expect(page).to have_content('sample text')
            expect(page).to_not have_content('Words with no meaning')
        end
    end
    
end