FactoryBot.define do
  factory :alarm_type do
    name { Faker::Movie.quote }
    type { Faker::Movie.quote }
    value { "0003" }
  end
end
