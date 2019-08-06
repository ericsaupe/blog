# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'test1234' }

    trait :author do
      after(:create) do |user, _evaluator|
        user.add_role(:author)
      end
    end

    trait :admin do
      after(:create) do |user, _evaluator|
        user.add_role(:admin)
      end
    end
  end
end
