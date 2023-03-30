# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Expenses Index Page', js: true do
  let(:user) { create(:user) }

  before do
    visit expenses_path
    fill_in 'login', with: user.login
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Log in'
  end

  scenario 'displays expenses list' do
    expense1 = create(:expense, user:, expense_type: 'Traveling')
    expense2 = create(:expense, user:, expense_type: 'Clothing')
    visit expenses_path

    expect(page).to have_content('Expenses')

    expect(page).to have_content(expense1.expense_type)
    expect(page).to have_content(expense1.value)
    expect(page).to have_content(expense1.description)
    expect(page).to have_content(expense1.created_at.strftime('(%H:%M) %d.%m.%Y'))

    expect(page).to have_content(expense2.expense_type)
    expect(page).to have_content(expense2.value)
    expect(page).to have_content(expense2.description)
    expect(page).to have_content(expense2.created_at.strftime('(%H:%M) %d.%m.%Y'))
  end

  context 'allows creation of new expense' do
    before do
      visit expenses_path
      click_link 'New expense'
    end

    scenario 'with valid attributes' do
      fill_in 'Value', with: 100
      fill_in 'Description', with: 'Lunch with friends'
      select 'Traveling', from: 'Expense Type:'
      click_button 'Create expense'

      expect(page).to have_content('Expense was successfully created.')
      expect(page).to have_content('Lunch with friends')
    end

    scenario 'with invalid value' do
      fill_in 'Value', with: ''
      fill_in 'Description', with: 'Lunch with friends'
      select 'Traveling', from: 'Expense Type:'
      click_button 'Create expense'

      expect(page).not_to have_content('Expense was successfully created.')
      expect(page).to have_content("Value can't be blank")
    end

    scenario 'with invalid expense type' do
      fill_in 'Value', with: 24.5
      fill_in 'Description', with: 'Lunch with friends'
      select 'All categories', from: 'Expense Type:'
      click_button 'Create expense'

      expect(page).not_to have_content('Expense was successfully created.')
      expect(page).to have_content("Expense type can't be blank")
    end

    scenario 'with invalid expense type and value' do
      fill_in 'Value', with: ''
      fill_in 'Description', with: 'Lunch with friends'
      select 'All categories', from: 'Expense Type:'
      click_button 'Create expense'

      expect(page).not_to have_content('Expense was successfully created.')
      expect(page).to have_content("Expense type can't be blank and value can't be blank")
    end
  end
end
