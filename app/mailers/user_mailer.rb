class UserMailer < ApplicationMailer
  def report_email(email, expenses)
    @expenses = expenses
    mail(to: email, subject: 'Expense Report')
  end

end