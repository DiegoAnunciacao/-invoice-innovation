class Invoice < ApplicationRecord
  attr_accessor :campo_virtual

  belongs_to :client
  has_many :services, inverse_of: :invoice, dependent: :destroy
  accepts_nested_attributes_for :services, reject_if: :all_blank, allow_destroy: true
  validates :vat, presence: true
  validate :validate_services

  private

  # def validates_services
  #   services.each do |service|
  #     errors.add(:base, "Service Description cannot be blank") if service.description.blank?
  #     errors.add(:base, "Service Amount cannot be blank") if service.amount.blank?
  #   end
  # end

  def validate_services
    if services.reject(&:marked_for_destruction?).blank?
      errors.add(:missing_services, "Invoice must have at least one Service.")
    end
  end
end
