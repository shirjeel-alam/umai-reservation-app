FactoryBot.define do
  factory :shift do
    name { %w(Morning Afternoon Evening Night).sample }
    start_at 32400
    end_at 54000
    restaurant
  end
end
