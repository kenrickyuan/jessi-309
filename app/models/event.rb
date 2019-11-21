class Event < ApplicationRecord
  has_many :guests
  has_many :expenses
  has_many :polls
end
