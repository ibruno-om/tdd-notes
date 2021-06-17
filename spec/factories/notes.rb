# frozen_string_literal: true

FactoryBot.define do
  factory :note do
    title { 'Some Note' }
    content { 'Content Note' }
    color { '#ccffff' }
    archived { false }
  end
end
