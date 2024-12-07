class Invoice < ApplicationRecord
  attr_accessor :campo_virtual

  belongs_to :client
  has_many :services, inverse_of: :invoice, dependent: :destroy
  accepts_nested_attributes_for :services, allow_destroy: true, reject_if: :all_blank
  validates :vat, presence: true
  validate :validate_services

  def subtotal
    services.sum(&:amount)
  end

  def vat_amount
    (subtotal * vat.to_f / 100).round(2)
  end

  def total
    (subtotal + vat_amount).round(2)
  end

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
