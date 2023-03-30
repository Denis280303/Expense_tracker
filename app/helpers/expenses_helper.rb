module ExpensesHelper
  def expense_type_select(f)
    f.select :expense_type_eq,
             options_for_select(Expense.expense_types.map { |k, v| [k.titleize, v] }, f.object.expense_type),
             { include_blank: 'All categories' },
             { class: "form-control" }
  end
end

