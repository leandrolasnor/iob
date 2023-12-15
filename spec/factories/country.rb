# frozen_string_literal: true

FactoryBot.define do
  factory :country do
    name { Faker::Address.country }
    code { Faker::Address.country_code }
    demographic_density { Faker::Number.decimal_part(digits: 4) }

    trait :allocate_resource do
      initialize_with { ShowCountry::Model::Country.new(attributes) }
    end
  end
end
