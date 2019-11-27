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
  end

  def show
    set_expense
    set_transactions
    settle_transactions
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

  def set_transactions
    @transactions = []
    Transaction.where(expense_id: @expense.id).order(:created_at).each do |transaction|
      @transactions << transaction
    end
    @transactions
  end

  def set_transaction_details(transaction)
    transaction_details = {}
    transaction_details[:payer] = transaction.payer
    transaction_details[:payee] = transaction.payee
    transaction_details[:datetime] = transaction.created_at
    transaction_details[:amount] = transaction.amount
    transaction_details[:difference] = @balance[transaction.payer.name]
    transaction_details
  end

  def settle_transactions
    @balance = Hash.new(0)
    @payment_transactions_hash = {}
    @payment_transactions = []
    @transactions.each do |transaction|
      if transaction.is_debt
        @balance[transaction.payer.name] = transaction.amount
        transaction_details = set_transaction_details(transaction)
        transaction_details[:is_debt] = true
        @payment_transactions_hash[transaction.payer] = transaction_details
      else
        @balance[transaction.payer.name] -= transaction.amount
        transaction_details = set_transaction_details(transaction)
        transaction_details[:is_debt] = false
        if @payment_transactions_hash[transaction.payer] == nil
          @payment_transactions_hash[transaction.payer] = transaction_details
        else
          @payment_transactions << @payment_transactions_hash[transaction.payer]
          @payment_transactions_hash[transaction.payer] = transaction_details
        end
      end
    end
  end

  def filter_by_description
    @expenses = @expenses.where(description: params[:search][:description])
  end

  def filter_by_guest
    @expenses = @expenses.where(guest: params[:search][:guest])
  end
end
