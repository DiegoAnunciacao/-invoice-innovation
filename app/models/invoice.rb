class Invoice < ApplicationRecord
  belongs_to :client
  has_many :services
end
