FactoryBot.define do
  factory :alarm_type do
    name { Faker::Movie.quote }
    type { :hardware }
    value { Faker::Number.number(3) }
  end
end
