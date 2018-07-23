FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category number #{n}" }
  end
end