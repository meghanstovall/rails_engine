class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity, :unit_price
  belongs_to :item
  belongs_to :invoice

  def convert_price
    unit_price / 100.to_f
  end
end
