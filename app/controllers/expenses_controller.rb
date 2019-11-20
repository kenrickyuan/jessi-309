class ExpensesController < ApplicationController
  before_action :set_expense, only: [:edit, :update, :destroy]
  before_action :set_event, only: [:new, :create]

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      redirect_to event_expenses_path
    else
      render :new
    end
  end

  def index
    @expenses = Expense.where(event_id: params[:event])
    filter_by_description if params[:description].present?
    filter_by_guest if params[:guest].present?
  end

  def edit
  end

  def update
    @expense.update(expense_params)
    redirect_to event_expenses_path
  end

  def destroy
    @expense.destroy
    redirect_to event_expenses_path
  end

  private

  def expense_params
    params.require('expense').permit(:description, :amount, :guest)
  end

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def filter_by_description
    @expenses = @expenses.where(description: params[:description])
  end

  def filter_by_guest
    @expenses = @expenses.where(guest: params[:guest])
  end
end
