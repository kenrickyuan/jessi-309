class Field < ApplicationRecord
  belongs_to :event
  belongs_to :poll
  validates :type, presence: true, inclusion: { in: ["email", "phonenumber", "multiple_choice"] }
end
