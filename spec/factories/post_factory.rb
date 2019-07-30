# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    association :author, factory: :user

    trait :anonymous do
      author { nil }
    end
  end
end
