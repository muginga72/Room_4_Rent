FactoryBot.define do
  factory :booking do
    check_in { Faker::Date.forward(days: 30) }
    check_out { Faker::Date.between(from: check_in, to: check_in + 7.days) }
    guest_name { Faker::Name.name }
    association :user
    association :room
  end
end