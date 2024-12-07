class Client < ApplicationRecord
  validates :name, :address, :county, :email, :postcode, :phone, presence: true
  belongs_to :user
  has_many :invoices

  def self.status
    @status = Client.status
  end

end
