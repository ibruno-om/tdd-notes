# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    description { Faker::Lorem.sentence }
    note
  end
end
