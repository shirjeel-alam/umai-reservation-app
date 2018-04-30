FactoryBot.define do
  factory :reservation do
    restaurant nil
    table nil
    shift nil
    guest nil
    guest_count 2
    reservation_at { Time.now.utc }
  end
end
