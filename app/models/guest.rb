class Guest < ApplicationRecord
  belongs_to :event
  has_many :expenses

  validates :name, presence: true
end
