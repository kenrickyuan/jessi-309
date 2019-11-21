class ExpensesController < ApplicationController
  before_action :set_expense, only: [:edit, :update, :destroy]
  before_action :set_event, only: [:new, :create, :index]


  # TODO: abstract @guests = Guest.where... into set_guest methods

  # TODO: iterate over the balance_per_guest hash
  # create two arrays of hashes, both with guest_id as keys, one with value as balance > 0 and the other with value as balance < 0
  # iterate over the postive array (balance > 0)
  # iterate over the negative array (balance < 0)
  # while the balance is > 0 in the positive array, add the negative array balance

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.event_id = @event.id
    if @expense.save!
      redirect_to event_expenses_path
    else
      render :new
    end
  end

  def index
    @expenses = Expense.where(event_id: params[:event_id])
    @guests_by_id = allocate_guests
    filter_by_description if params[:search] && params[:search][:description].present?
    filter_by_guest if params[:search] && params[:search][:guest].present?
    @balance_per_guest = calculate_balance
    @expenses
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
    params.require(:expense).permit(:description, :amount, :guest_id)
  end

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def filter_by_description
    @expenses = @expenses.where(description: params[:search][:description])
  end

  def filter_by_guest
    @expenses = @expenses.where(guest: params[:search][:guest])
  end

  def calculate_balance
    balance_per_guest = {}
    @guests = Guest.where(event_id: params[:event_id])
    @guests.each do |guest|
      balance_per_guest[guest.id] = 0
    end
    @expenses.each do |expense|
      balance = expense.amount / @guests.size
      balance_per_guest[expense.guest_id] += balance
      @guests.each do |guest|
        next if guest.id == expense.guest_id

        balance_per_guest[guest.id] -= balance
      end
    end
    balance_per_guest
  end

  def allocate_guests
    @guests = Guest.where(event_id: params[:event_id])
    @guests_by_id = {}
    @guests.each do |guest|
      @guests_by_id[guest.id] = guest.name
    end
    @guests_by_id
  end
end
