class Poll < ApplicationRecord
  belongs_to :event
  has_many :fields
end
