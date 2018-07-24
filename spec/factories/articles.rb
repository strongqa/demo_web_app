FactoryBot.define do
  factory :article do
    sequence(:title) { |t| "Title-#{t}-" }
    category
    trait :with_tags do
      after(:create) do |f|
        f.tags = create_list(:tag, 2)
        f.save!
      end
    end
  end
end
