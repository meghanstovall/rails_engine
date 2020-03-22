require 'rails_helper'

RSpec.describe Merchant, type: :model do

  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should have_many :items}
    it {should have_many :invoices}
  end

  describe 'methods' do
    before :each do
      @merchant1 = Merchant.create!(name: "Willms and Sons", created_at: "2020-03-22")
      @merchant2 = Merchant.create!(name: "Turing School", created_at: "2020-03-22")
      @merchant3 = Merchant.create!(name: "Pets 4 Paws", created_at: "2020-03-22")
      @merchant4 = Merchant.create!(name: "Ring World", created_at: "2020-03-22")
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

    it "#single_search" do
      search_params = {name: "ring"}

      expect(Merchant.single_search(search_params).first.class).to eq(Merchant)
      expect(Merchant.single_search(search_params).count).to eq(1)
    end

    it "#multi_search" do
      merchant1 = Merchant.create!(name: "Tom")
      merchant2 = Merchant.create!(name: "Tommy")
      merchant3 = Merchant.create!(name: "Marry")
      search_params = {name: "Tom"}

      expect(Merchant.multi_search(search_params).count).to eq(2)
    end

    it "#most_revenue" do
      expect(Merchant.most_revenue(1)).to eq([@merchant2])
      expect(Merchant.most_revenue(2)).to eq([@merchant2, @merchant3])
    end

    it "#most_items" do
      expect(Merchant.most_items(2)).to eq([@merchant2, @merchant3])
    end

    it "#total_date_revenue" do
      start_date = "2020-03-21"
      end_date = "2020-03-31"

      expect(Merchant.total_date_revenue(start_date.to_time, end_date.to_time)).to eq(10045.0)
    end

    it "#merchant_revenue" do
      expect(Merchant.merchant_revenue(@merchant1.id)).to eq(20.0)
      expect(Merchant.merchant_revenue(@merchant2.id)).to eq(10000.0)
      expect(Merchant.merchant_revenue(@merchant3.id)).to eq(25.0)
    end
  end
end
