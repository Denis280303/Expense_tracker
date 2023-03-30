FactoryBot.define do
  CATEGORIES = ['Traveling', 'Clothing', 'Taxi', 'Cafes', 'Shops', 'Other']

  factory :expense do
    sequence(:expense_type) { CATEGORIES[rand(1..5)] }
    sequence(:value) { |n| n }
    sequence(:description) { |n| "Description ##{n}" }

    user { nil }
  end
end