FactoryBot.define do
  factory :expense do
    sequence(:expense_type) { |n| n }
    sequence(:value) { |n| n }
    sequence(:description) { |n| "Description ##{n}" }

    user { nil }
  end
end