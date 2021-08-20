# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
50.times do
  Note.create(title: Faker::Lorem.sentence,
              content: Faker::Lorem.paragraph,
              color: Faker::Color.hex_color,
              archived: [true, false].sample)
end

@notes = Note.all
100.times do
  Item.create(description: Faker::Lorem.sentence, note: @notes.sample)
end
