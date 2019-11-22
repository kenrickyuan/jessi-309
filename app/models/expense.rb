class Expense < ApplicationRecord
  belongs_to :event
  belongs_to :guest
  has_many :transactions, dependent: :destroy

  monetize :amount_cents
end
