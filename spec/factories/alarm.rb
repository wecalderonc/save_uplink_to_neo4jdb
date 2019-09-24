require 'faker'

FactoryBot.define do
  factory :alarm do
    value { "0001" }
    viewed { false }

    association :uplink, factory: :uplink
  end
end
