require 'rails_helper'

RSpec.describe Post, type: :model do
  person = Person.create(name: 'Test Name')

  post = Post.new(
    date: DateTime.now,
    network: 'Facebook',
    link: 'https://google.com',
    person: person,
    text: 'Sample text'
  )
  it "is valid with valid attributes" do
    expect(post).to be_valid
  end

  it "is not valid without a person" do
    post.person = nil
    expect(post).to_not be_valid
  end
  it "is not valib without a date" do
    post.date = nil
    expect(post).to_not be_valid
  end

  it "is not valid without a link" do
    post.link = nil
    expect(post).to_not be_valid
  end
  it "is not valid without a network" do
    post.network = nil
    expect(post).to_not be_valid
  end
end
