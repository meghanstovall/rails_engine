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

    it "#single_search" do
      merchant = create(:merchant)
      item1 = Item.create!({name: "mountain bike", description: "Good for beginners", unit_price: 22555, merchant: merchant})
      item2 = Item.create!({name: "mountain bike", description: "Good for all riders", unit_price: 22555, merchant: merchant})
      search_params = {name: "mountain bike"}

      expect(Item.single_search(search_params).first.class).to eq(Item)
    end

    it "#multi_search" do
      merchant = create(:merchant)
      item1 = Item.create!({name: "mountain bike", description: "Good for beginners", unit_price: 22555, merchant: merchant})
      item2 = Item.create!({name: "mountain bike", description: "Good for all riders", unit_price: 22555, merchant: merchant})
      item3 = Item.create!({name: "bike", description: "Good for all riders", unit_price: 22555, merchant: merchant})
      search_params = {name: "mountain"}

      expect(Item.multi_search(search_params).count).to eq(2)
    end
  end
end
