class Client < ApplicationRecord
  validates :name, :address, :county, :email, :postcode, :phone, presence: true
  belongs_to :user
  has_many :invoices, dependent: :destroy

end
