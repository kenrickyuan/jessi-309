class Expense < ApplicationRecord
  belongs_to :event
  belongs_to :guest
  has_many :transactions, dependent: :destroy

  validates :event, presence: true
  validates :guest, presence: true
  validates :description, presence: true
  validates :amount, presence: true, numericality: true

  monetize :amount_cents
end
