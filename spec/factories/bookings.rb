FactoryBot.define do
  factory :booking do |f|
    f.check_in { Faker::Date.check_in }
    f.check_out { Faker::Date.check_out }
  end
end
