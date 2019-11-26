class Event < ApplicationRecord
  has_many :guests, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :polls, dependent: :destroy

  validates :title, presence: true
end
