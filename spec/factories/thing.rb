require 'faker'

FactoryBot.define do
  factory :thing do
    name { Faker::Lorem.word }
    status { "activated" }
    pac { Faker::Alphanumeric.alphanumeric 7 }
    company_id { Faker::Number.decimal_part(5) }

    trait :activated do
      status { "activated" }
    end

    trait :deactivated do
      status { "deactivated" }
    end
  end
end
