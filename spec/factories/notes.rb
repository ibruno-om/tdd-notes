# frozen_string_literal: true

# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  title      :string
#  content    :text
#  color      :string
#  archived   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :note do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    color { Faker::Color.hex_color }
    archived { [true, false].sample }
    user
    factory :note_with_images do
      images do
        [
          Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/assets/images/todoist-001.jpg"),
          Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/assets/images/todoist-002.jpg")
        ]
      end
    end
  end
end
