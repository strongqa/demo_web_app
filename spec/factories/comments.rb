FactoryGirl.define do
  factory :comment do
    user
    body 'Hello, World!'
  end
end
