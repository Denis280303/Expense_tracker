FactoryBot.define do
  factory :user do
    sequence(:login) { |n| "user#{n*3}login" }
    sequence(:email) { |n| "user#{n*3}@example.com" }
    password { SecureRandom.hex(10) }
  end
end
