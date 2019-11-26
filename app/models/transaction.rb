class Transaction < ApplicationRecord
  belongs_to :expense
  belongs_to :payer, class_name: 'Guest'
  belongs_to :payee, class_name: 'Guest'

  validates :payer, presence: true
  validates :payee, presence: true
  validates :expense, presence: true
  validates :amount, presence: true, numericality: true

  monetize :amount_cents
end
