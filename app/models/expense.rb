class Expense < ApplicationRecord
  CATEGORIES = ['Traveling', 'Clothing', 'Taxi', 'Cafes', 'Shops', 'Other']

  enum expense_type: CATEGORIES

  belongs_to :user
  validates :expense_type, :value, presence: true

  scope :ordered, -> { order(created_at: :desc) }

  broadcasts_to ->(expense) { [expense.user, "expenses"] }, inserts_by: :prepend

  def self.ransackable_attributes(auth_object = nil)
    %w[value description created_at user_id expense_type]
  end
end
