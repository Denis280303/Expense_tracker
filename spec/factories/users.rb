FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n*3}@example.com" }
    password { SecureRandom.hex(10) }
  end
end
