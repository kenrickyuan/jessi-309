class ExpensesController < ApplicationController
  before_action :set_event, only: [:new, :create, :index, :show]

  def new
    @expense = Expense.new
    @transaction = Transaction.new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.event_id = @event.id
    if @expense.save!
      @event.guests.each do |guest|
        next if guest.id == @expense.guest_id

        @transaction = Transaction.new
        @transaction.expense_id = @expense.id
        @transaction.payer = guest
        @transaction.payee = @expense.guest
        amount = @expense.amount / @event.guests.size
        @transaction.amount = amount
        @transaction.is_debt = true
        unless @transaction.save!
          render :new
        end
      end
      redirect_to event_expenses_path
    else
      render :new
    end
  end

  def index
    @expenses = @event.expenses
    filter_by_description if params[:search] && params[:search][:description].present?
    filter_by_guest if params[:search] && params[:search][:guest].present?
    # For testing
    @guests_by_id = allocate_guests
    calculate_balance
    # For testing ^^^
    @expenses
  end

  def show
    set_expense
    set_transactions
  end

  def destroy
    set_expense
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
    @guests = @event.guests
  end

  def set_transactions
    @transactions = {}
    @event.expenses.each do |expense|
      @transactions[expense.id] = []
      Transaction.where(expense_id: expense.id).each do |transaction|
        @transactions[expense.id] << transaction
      end
      @transactions.delete(expense.id) if @transactions[expense.id].empty?
    end
    @transactions
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
    @balance_per_guest = {}
    set_guests
    @guests.each do |guest|
      @balance_per_guest[guest.id] = 0
    end
    @expenses.each do |expense|
      balance = expense.amount / @guests.size
      @balance_per_guest[expense.guest_id] += balance
      @guests.each do |guest|
        next if guest.id == expense.guest_id

        @balance_per_guest[guest.id] -= balance
      end
    end
    @balance_per_guest
  end

  # def calculate_outstanding_balance
  #   positive_balances = []
  #   negative_balances = []
  #   @balance_per_guest.each do |key, value|
  #     if value > 0
  #       positive_balances << { key => value }
  #     else
  #       negative_balances << { key => value }
  #     end
  #   end
  #   positive_balances.each do |positive_balance|
  #     while positive_balance.values.first != 0
  #       negative_balances.each do |negative_balance|
  #         positive_balance.values.first + negative_balance.values.first
  #       end
  #     end
  #   end
  # end

end
