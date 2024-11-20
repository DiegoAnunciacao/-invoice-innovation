class Invoice < ApplicationRecord
  belongs_to :client
  has_many :services, dependent: :destroy
  accepts_nested_attributes_for :services, reject_if: :all_blank, allow_destroy: true
end
