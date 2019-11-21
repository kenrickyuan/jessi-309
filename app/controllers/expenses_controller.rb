class ExpensesController < ApplicationController
  before_action :set_expense, only: [:edit, :update, :destroy]
  before_action :set_event, only: [:new, :create, :index]

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
    @outstanding_balance_per_guest = calculate_outstanding_balance
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

  def set_guests
    # Can I call @expense.guests instead of this method?
    @guests = Guest.where(event_id: params[:event_id])
  end

  def filter_by_description
    @expenses = @expenses.where(description: params[:search][:description])
  end

  def filter_by_guest
    @expenses = @expenses.where(guest: params[:search][:guest])
  end

  def allocate_guests
    set_guests
    @guests_by_id = {}
    @guests.each do |guest|
      @guests_by_id[guest.id] = guest.name
    end
    @guests_by_id
  end

  def calculate_balance
    balance_per_guest = {}
    set_guests
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

  # TODO: iterate over the balance_per_guest hash
  # create two arrays of hashes, both with guest_id as keys, one with value as balance > 0 and the other with value as balance < 0
  # iterate over the postive array (balance > 0)
  # iterate over the negative array (balance < 0)
  # while the balance is > 0 in the positive array, add the negative array balance
  def calculate_outstanding_balance
    positive_balances = []
    negative_balances = []
    @balance_per_guest.each do |key, value|
      if value > 0
        positive_balances << { key: value }
      else
        negative_balances << { key: value }
      end
    end
    positive_balances.each do |positive_balance|
      while positive_balance.values.first > 0
        negative_balances.each do |negative_balance|
          positive_balance.values.first + negative_balance.values.first
        end
      end
    end
    raise
  end

end
