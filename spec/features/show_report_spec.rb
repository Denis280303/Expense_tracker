require 'rails_helper'

RSpec.feature "Show report", type: :feature, js: true do
  let!(:user) { create(:user) }
  let!(:expense1) { create(:expense, user: user, value: 10, expense_type: "Traveling") }
  let!(:expense2) { create(:expense, user: user, value: 20, expense_type: "Clothing") }

  before do
    visit expenses_path
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Log in'
  end

  scenario "User can search and sort expenses" do
    visit show_report_path

    # Fill in the search form
    select "Traveling", from: "Expense Type:"
    fill_in "Less than:", with: 15
    fill_in "More than:", with: 5
    click_button "Sort"

    # Verify that only the correct expenses are displayed
    expect(page).to have_selector(".expense", count: 1)

    # Fill in the send report form and send the report
    fill_in "Share with:", with: "test@example.com"
    click_button "Send Report"

    # Verify that the success message is displayed
    expect(page).to have_selector(".flash__message", text: "Expenses sent successfully!")
  end
end