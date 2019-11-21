class Poll < ApplicationRecord
  belongs_to :event
  validates :field_type, presence: true, inclusion: { in: ["email", "phonenumber", "multiple_choice"] }
end
