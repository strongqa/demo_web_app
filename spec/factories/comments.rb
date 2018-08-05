FactoryBot.define do
  factory :comment do
    user
    article
    sequence(:body) { |b| "Hello, World!-#{b}" }
  end
end
