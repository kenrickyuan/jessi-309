class Event < ApplicationRecord
  has_many :guests
  has_many :expenses
end
