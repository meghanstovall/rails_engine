require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
  end

  describe 'relationships' do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'methods' do
    it '#convert_price' do
      item = Item.create({name: "mountain bike", description: "Good for beginners", unit_price: 22555})

      expect(item.convert_price).to eq(225.55)
    end
  end
end
