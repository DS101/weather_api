class Weather < ApplicationRecord
  validates :time, presence: true
  validates :temperature, presence: true
end
