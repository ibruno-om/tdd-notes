# frozen_string_literal: true

namespace :db do
  desc 'This task generates fake data'
  task generate_data_faker: :environment do
    @user = User.create(email: 'neo@tddnotes.com', name: 'Thomas Anderson', password: 'Tdd-Notes1')

    @notes = []
    50.times do
      @notes << Note.create(title: Faker::Lorem.sentence,
                            content: Faker::Lorem.paragraph,
                            color: Faker::Color.hex_color,
                            archived: [true, false].sample,
                            user: @user)
    end

    100.times do
      Item.create(description: Faker::Lorem.sentence, note: @notes.sample)
    end
  end
end
