class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.integer :expense_type
      t.integer :value
      t.text :description

      t.timestamps
    end
  end
end
