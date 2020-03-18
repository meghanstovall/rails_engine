require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do

  describe 'validations' do
    it {should validate_presence_of :quantity}
    it {should validate_presence_of :unit_price}
  end

  describe 'relationships' do
    it {should belong_to :item}
    it {should belong_to :invoice}
  end

  describe 'methods' do
    it '#convert_price' do
      customer = Customer.create!({first_name: "Joey", last_name: "Ondricka"})
      merchant = Merchant.create!({name: "Willms and Sons"})
      item = merchant.items.create!({name: "mountain bike", description: "Good for beginners", unit_price: 22555})
      invoice = Invoice.create!({customer: customer, merchant: merchant, status: "shipped"})
      invoice_item = InvoiceItem.create!({quantity: 5, unit_price: 13635, item: item, invoice: invoice})

      expect(invoice_item.convert_price).to eq(136.35)
    end
  end
end
