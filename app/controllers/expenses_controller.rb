class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  def index
    @expenses = current_user.expenses.ordered
  end

  def show
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = current_user.expenses.build(expense_params)

    if @expense.save
      respond_to do |format|
        format.html { redirect_to expenses_path, notice: "Expense was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Expense was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @expense.update(expense_params)
      respond_to do |format|
        format.html { redirect_to expenses_path, notice: "Expense was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Expense was successfully updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_path, notice: "Expense was successfully destroyed." }
      format.turbo_stream { flash.now[:notice] = "Expense was successfully destroyed." }
    end
  end

  private

  def set_expense
    @expense = current_user.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:expense_type, :value, :description)
  end

end
