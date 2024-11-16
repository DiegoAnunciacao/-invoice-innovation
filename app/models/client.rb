class Client < ApplicationRecord
  validates :client_name, :client_address, :client_county, :client_email, :client_postcode, :client_phone, presence: true
  belongs_to :user
  has_many :invoices
end
