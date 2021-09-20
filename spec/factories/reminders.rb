FactoryBot.define do
  factory :reminder do
    note
    notification_time { Time.now }
  end
end
