# frozen_string_literal: true

FactoryBot.define do
  factory :note do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    color { Faker::Color.hex_color }
    archived { [true, false].sample }
  end
end
