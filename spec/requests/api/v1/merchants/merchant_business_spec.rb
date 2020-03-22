require 'rails_helper'

describe 'Merchants API' do
  describe 'business intelligence' do
    before :each do
      @merchant1 = Merchant.create!(name: "Willms and Sons")
      @merchant2 = Merchant.create!(name: "Turing School")
      @merchant3 = Merchant.create!(name: "Pets 4 Paws")
      @customer = Customer.create!(first_name: "Matteo", last_name: "Sludge")

      @invoice1 = Invoice.create!(status: "shipped", customer: @customer, merchant: @merchant1)
      @invoice2 = Invoice.create!(status: "shipped", customer: @customer, merchant: @merchant2)
      @invoice3 = Invoice.create!(status: "shipped", customer: @customer, merchant: @merchant3)

      @item1 = Item.create!(name: "fishing pole", description: "good for begginers", unit_price: 20, merchant: @merchant1)
      @item2 = Item.create!(name: "mac book pro", description: "good for begginer coders", unit_price: 1000, merchant: @merchant2)
      @item3 = Item.create!(name: "dog bowl", description: "for small dogs", unit_price: 5, merchant: @merchant3)

      @pole_willms = InvoiceItem.create!(quantity: 1, unit_price: 20, item: @item1, invoice: @invoice1)
      @mac_turing = InvoiceItem.create!(quantity: 10, unit_price: 1000, item: @item2, invoice: @invoice2)
      @dog_paws = InvoiceItem.create!(quantity: 5, unit_price: 5, item: @item3, invoice: @invoice3)

      @transaction1 = create(:transaction, invoice: @invoice1)
      @transaction2 = create(:transaction, invoice: @invoice2)
      @transaction3 = create(:transaction, invoice: @invoice3)
    end

    it "can return variable number of merchants with most revenue" do
      get "/api/v1/merchants/most_revenue?quantity=2"

      merchants = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(merchants.count).to eq(2)
      expect(merchants[0][:attributes][:name]).to eq(@merchant2.name)
      expect(merchants[-1][:attributes][:name]).to eq(@merchant3.name)
    end
  end
end
