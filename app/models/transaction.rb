class Transaction < ApplicationRecord
  belongs_to :expense
  belongs_to :payer, class_name: 'Guest'
  belongs_to :payee, class_name: 'Guest'

  monetize :amount_cents
end
