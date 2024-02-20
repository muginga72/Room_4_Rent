FactoryBot.define do
  factory :comment do
    body { "MyText" }
    user { nil }
    room { nil }
  end
end
