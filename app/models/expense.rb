class Expense < ApplicationRecord
  belongs_to :user
  validates :expense_type, :value, presence: true

  scope :ordered, -> { order(created_at: :desc) }

  broadcasts_to ->(expense) { [expense.user, "expenses"] }, inserts_by: :prepend
end
