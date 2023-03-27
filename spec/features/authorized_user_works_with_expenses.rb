require 'rails_helper'

feature 'Accountant works with own expenses' do
  let(:user) { create(:user) }
  let(:new_expense) { create(:expense, user: user)}
  let!(:existed_expense) { create(:expense, user: user)}

  before do
    visit expenses_path
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Log in'
  end

  context 'with creating new expense' do
    before do
      click_link 'New expense'
    end

    scenario 'when valid params' do
      fill_in 'Expense type', with: new_expense.expense_type
      fill_in 'Value', with: new_expense.value
      fill_in 'Description', with: new_expense.description
      click_button 'Create expense'
      expect(page).to have_content 'Expense was successfully created.'
    end

    scenario 'when value invalid' do
      fill_in 'Expense type', with: new_expense.expense_type
      fill_in 'Value', with: ''
      fill_in 'Description', with: new_expense.description
      click_button 'Create expense'
      expect(page).not_to have_content 'Expense was successfully created.'
      expect(page).to have_content "Value can't be blank"
    end

    scenario 'when expense_type invalid' do
      fill_in 'Expense type', with: ''
      fill_in 'Value', with: new_expense.value
      fill_in 'Description', with: new_expense.description
      click_button 'Create expense'
      expect(page).not_to have_content 'Expense was successfully created.'
      expect(page).to have_content "Expense type can't be blank"
    end

    scenario 'when expense_type and value invalid' do
      fill_in 'Expense type', with: ''
      fill_in 'Value', with: ''
      fill_in 'Description', with: new_expense.description
      click_button 'Create expense'
      expect(page).not_to have_content 'Expense was successfully created.'
      expect(page).to have_content "Expense type can't be blank and value can't be blank"
    end
  end

  context 'with updating existed expense' do
    before do
      click_link 'Edit'
      fill_in 'Expense type', with: 4
      fill_in 'Value', with: 5
      fill_in 'Description', with: 'New description'
    end

    scenario 'when confirm editing' do
      click_button 'Update expense'
      expect(page).to have_content 'Expense was successfully updated.'
    end

    scenario 'when cancel editing' do
      click_link 'Cancel'
      expect(page).not_to have_content 'Expense was successfully updated.'
    end
  end

  scenario 'with destroying existed expense' do
    click_button 'Delete'
    expect(page).to have_content 'Expense was successfully destroyed.'
    expect(page).not_to have_content existed_expense.expense_type
    expect(page).not_to have_content existed_expense.value
    expect(page).not_to have_content existed_expense.description
  end
end