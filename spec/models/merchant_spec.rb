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
    it "#single_search" do
      merchant1 = Merchant.create!(name: "Tom")
      merchant2 = Merchant.create!(name: "Tommy")
      search_params = {name: "Tom"}

      expect(Merchant.single_search(search_params).first.class).to eq(Merchant)
    end

    it "#multi_search" do
      merchant1 = Merchant.create!(name: "Tom")
      merchant2 = Merchant.create!(name: "Tommy")
      merchant3 = Merchant.create!(name: "Marry")
      search_params = {name: "Tom"}

      expect(Merchant.multi_search(search_params).count).to eq(2)
    end
  end
end
