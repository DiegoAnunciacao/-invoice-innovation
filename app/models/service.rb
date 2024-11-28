class Service < ApplicationRecord
  belongs_to :invoice, inverse_of: :services

  validates :description, presence: true
  validates :amount, presence: true
end
