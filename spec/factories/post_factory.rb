# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    association :author, factory: :user

    after(:create) do |post, _evaluator|
      create(:action_text, record: post)
    end

    trait :anonymous do
      author { nil }
    end

    trait :with_tag do
      after(:create) do |post, _evaluator|
        post.tags << create(:tag)
      end
    end
  end
end
