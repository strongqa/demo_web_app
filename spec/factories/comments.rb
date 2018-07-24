FactoryBot.define do
  factory :comment do
    user
    sequence(:body) { |b| "Hello, World!-#{b}" }
  end
end
