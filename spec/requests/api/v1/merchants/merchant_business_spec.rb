require 'rails_helper'

describe 'Merchants API' do
  describe 'business intelligence' do
    before :each do
      @merchant1 = Merchant.create!(name: "Willms and Sons", created_at: "2020-03-22")
      @merchant2 = Merchant.create!(name: "Turing School", created_at: "2020-03-22")
      @merchant3 = Merchant.create!(name: "Pets 4 Paws", created_at: "2020-03-22")
      @customer = Customer.create!(first_name: "Matteo", last_name: "Sludge", created_at: "2020-03-22")

      @invoice1 = Invoice.create!(status: "shipped", customer: @customer, merchant: @merchant1, created_at: "2020-03-22")
      @invoice2 = Invoice.create!(status: "shipped", customer: @customer, merchant: @merchant2, created_at: "2020-03-22")
      @invoice3 = Invoice.create!(status: "shipped", customer: @customer, merchant: @merchant3, created_at: "2020-03-22")

      @item1 = Item.create!(name: "fishing pole", description: "good for beginners", unit_price: 20, merchant: @merchant1, created_at: "2020-03-22")
      @item2 = Item.create!(name: "mac book pro", description: "good for beginner coders", unit_price: 1000, merchant: @merchant2, created_at: "2020-03-22")
      @item3 = Item.create!(name: "dog bowl", description: "for small dogs", unit_price: 5, merchant: @merchant3, created_at: "2020-03-22")
      @item4 = Item.create!(name: "fly fishing pole", description: "good for advanced", unit_price: 80, merchant: @merchant1, created_at: "2020-03-22")
      @item5 = Item.create!(name: "rain coat", description: "red and all sizes", unit_price: 15, merchant: @merchant1, created_at: "2020-03-22")
      @item6 = Item.create!(name: "t-shirt", description: "good for everyone", unit_price: 5, merchant: @merchant2, created_at: "2020-03-22")

      @pole_willms = InvoiceItem.create!(quantity: 1, unit_price: 20, item: @item1, invoice: @invoice1, created_at: "2020-03-22")
      @mac_turing = InvoiceItem.create!(quantity: 10, unit_price: 1000, item: @item2, invoice: @invoice2, created_at: "2020-03-22")
      @dog_paws = InvoiceItem.create!(quantity: 5, unit_price: 5, item: @item3, invoice: @invoice3, created_at: "2020-03-22")

      @transaction1 = create(:transaction, invoice: @invoice1, created_at: "2020-03-22")
      @transaction2 = create(:transaction, invoice: @invoice2, created_at: "2020-03-22")
      @transaction3 = create(:transaction, invoice: @invoice3, created_at: "2020-03-22")
    end

    it "can return variable number of merchants with most revenue" do
      get "/api/v1/merchants/most_revenue?quantity=2"

      merchants = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(merchants.count).to eq(2)
      expect(merchants[0][:attributes][:name]).to eq(@merchant2.name)
      expect(merchants[-1][:attributes][:name]).to eq(@merchant3.name)
    end

    it "can return variable number of merchants that have sold the most items" do
      get "/api/v1/merchants/most_items?quantity=2"

      merchants = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(merchants.count).to eq(2)
      expect(merchants[0][:attributes][:name]).to eq(@merchant2.name)
      expect(merchants[-1][:attributes][:name]).to eq(@merchant3.name)
    end

    it "can return a merchants revenue" do
      get "/api/v1/merchants/#{@merchant1.id}/revenue"

      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(data[:id]).to eq(@merchant1.id)
      expect(data[:attributes][:revenue]).to eq(20.0)
    end
  end
end
