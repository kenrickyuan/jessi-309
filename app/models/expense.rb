class Expense < ApplicationRecord
  belongs_to :event
  belongs_to :guest

  monetize :amount_cents
end
