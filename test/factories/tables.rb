FactoryBot.define do
  factory :table do
    sequence(:name) { |n| "Table-#{n}" }
    minimum_capacity 1
    maximum_capacity 10
    restaurant
  end
end
