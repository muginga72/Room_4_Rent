FactoryBot.define do
  factory :user do
    full_name { "Alice Smith" }
  end

  factory :room do
    room_address { Faker::Address.street_address }
    room_city { Faker::Address.city }
    room_state { Faker::Address.state }
    room_zip { Faker::Address.zip }
    room_country { Faker::Address.country }
    room_price { Faker::Number.decimal(l_digits: 2) }
    room_description { Faker::Lorem.sentence }
    room_smoke { Faker::Boolean.boolean }
    number_of_beds { Faker::Number.between(from: 1, to: 4) }

    association :user
  end
end