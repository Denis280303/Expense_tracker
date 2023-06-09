# frozen_string_literal: true

class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[show edit update destroy]
  def index
    @expenses = current_user.
      expenses.ordered.
      paginate(page: params[:page], per_page: 10)
  end

  def show; end

  def new
    @expense = Expense.new
  end

  def create
    @expense = current_user.expenses.build(expense_params)

    if @expense.save
      respond_to do |format|
        format.html { redirect_to expenses_path, notice: 'Expense was successfully created.' }
        format.turbo_stream { flash.now[:notice] = 'Expense was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @expense.update(expense_params)
      respond_to do |format|
        format.html { redirect_to expenses_path, notice: 'Expense was successfully updated.' }
        format.turbo_stream { flash.now[:notice] = 'Expense was successfully updated.' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_path, notice: 'Expense was successfully destroyed.' }
      format.turbo_stream { flash.now[:notice] = 'Expense was successfully destroyed.' }
    end
  end

  def show_report
    @@scope_of_expenses = current_user.expenses
    @q = current_user.expenses.ransack(params[:q])
    @expenses = @q.
      result(distinct: true).
      order(created_at: :desc).
      paginate(page: params[:page], per_page: 10)
    @@scope_of_expenses = @expenses
  end

  def send_report
    @expenses = @@scope_of_expenses.present? ? @@scope_of_expenses : current_user.expenses
    UserMailer.report_email(params[:email], @expenses).deliver_now
    flash[:notice] = 'Expenses sent successfully!'
    redirect_to show_report_path
  end

  private

  def set_expense
    @expense = current_user.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:expense_type, :value, :description)
  end
end
