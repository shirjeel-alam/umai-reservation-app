FactoryBot.define do
  factory :restaurant do
    sequence(:name) { |n| "Restaurant-#{n}" }
    email { Faker::Internet.email }
    phone "0191234567"
  end
end
