FactoryBot.define do
  factory :action_text, class: 'ActionText::RichText' do
    name { 'content' }
    body { ActionText::Content.new(Faker::Lorem.sentence) }
    association :record, factory: :post
  end
end
