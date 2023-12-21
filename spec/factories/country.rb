# frozen_string_literal: true

FactoryBot.define do
  factory :country do
    name { Faker::Address.country }
    code { Faker::Address.country_code }
    demographic_density { rand(300..9999) }

    trait :allocate_resource do
      initialize_with { ShowCountry::Model::Country.new(attributes) }
    end
  end
end
