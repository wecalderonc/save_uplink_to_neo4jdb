require 'faker'

FactoryBot.define do
  factory :alarm_type do
    name { Faker::Movie.quote }
    type { :hardware }
    value { "0003" }
  end
end
