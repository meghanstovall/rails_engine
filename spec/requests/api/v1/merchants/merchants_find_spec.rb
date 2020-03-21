require 'rails_helper'

describe 'Merchants API' do
  describe 'single finders' do
    it "can find a merchant by id" do
      new_merchant = create(:merchant)

      get "/api/v1/merchants/find?id=#{new_merchant.id}"

      merchant = JSON.parse(response.body, symbolize_names: true)[:data][0]

      expect(response).to be_successful
      expect(merchant[:attributes][:id]).to eq(new_merchant.id)
    end

    it "can find a merchant by name" do
      new_merchant = create(:merchant)

      get "/api/v1/merchants/find?name=#{new_merchant.name}"

      merchant = JSON.parse(response.body, symbolize_names: true)[:data][0]

      expect(response).to be_successful
      expect(merchant[:attributes][:name]).to eq(new_merchant.name)
    end

    it "can find a merchant by created at attribute" do
      new_merchant = create(:merchant, created_at: "2020-03-20 04:50:08 UTC")

      get "/api/v1/merchants/find?created_at=#{new_merchant.created_at}"

      merchant = JSON.parse(response.body, symbolize_names: true)[:data][0]

      expect(response).to be_successful
      expect(merchant[:attributes][:id]).to eq(new_merchant.id)
    end

    it "can find a merchant by updated at attribute" do
      new_merchant = create(:merchant, updated_at: "2020-03-20 04:50:08 UTC")

      get "/api/v1/merchants/find?updated_at=#{new_merchant.updated_at}"

      merchant = JSON.parse(response.body, symbolize_names: true)[:data][0]

      expect(response).to be_successful
      expect(merchant[:attributes][:id]).to eq(new_merchant.id)
    end

    it "can find merchant by name and created_at" do
      new_merchant = create(:merchant, created_at: "2020-03-20 04:50:08 UTC")

      get "/api/v1/merchants/find?name=#{new_merchant.name.downcase}&created_at=#{new_merchant.created_at}"

      merchant = JSON.parse(response.body, symbolize_names: true)[:data][0]

      expect(response).to be_successful
      expect(merchant[:attributes][:name]).to eq(new_merchant.name)
      expect(merchant[:attributes][:id]).to eq(new_merchant.id)
    end

    it "can find merchant by name and updated_at" do
      new_merchant = create(:merchant, updated_at: "2020-03-20 04:50:08 UTC")

      get "/api/v1/merchants/find?name=#{new_merchant.name.downcase}&updated_at=#{new_merchant.updated_at}"

      merchant = JSON.parse(response.body, symbolize_names: true)[:data][0]

      expect(response).to be_successful
      expect(merchant[:attributes][:name]).to eq(new_merchant.name)
      expect(merchant[:attributes][:id]).to eq(new_merchant.id)
    end
  end

  describe 'multiple finders' do
    it "can find all merchants by name" do
      merchant1 = Merchant.create!(name: "Turing")
      merchant2 = Merchant.create!(name: "Turing")

      get "/api/v1/merchants/find_all?name=#{merchant1.name}"

      merchants = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(merchants.count).to eq(2)
      expect(merchants[0][:attributes][:name]).to eq(merchant1.name)
      expect(merchants[1][:attributes][:name]).to eq(merchant2.name)
    end

    it "can find all merchants by partial name" do
      merchant1 = Merchant.create!(name: "Turing")
      merchant2 = Merchant.create!(name: "Ring World")
      merchant3 = Merchant.create!(name: "Willms and Sons")

      get "/api/v1/merchants/find_all?name=ring"

      merchants = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(merchants.count).to eq(2)
      expect(merchants[0][:attributes][:name]).to eq(merchant1.name)
      expect(merchants[1][:attributes][:name]).to eq(merchant2.name)
    end

    it "can find all merchants by a created_at" do
      merchant1 = Merchant.create!(name: "Turing", created_at: "2020-03-20 04:50:08 UTC")
      merchant2 = Merchant.create!(name: "Turing", created_at: "2020-03-20 04:50:08 UTC")
      merchant3 = Merchant.create!(name: "Matteo")

      get "/api/v1/merchants/find_all?created_at=#{merchant1.created_at}"

      merchants = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(merchants.count).to eq(2)
      expect(merchants[0][:attributes][:id]).to eq(merchant1.id)
      expect(merchants[1][:attributes][:id]).to eq(merchant2.id)
    end

    it "can find all merchants by a updated_at" do
      merchant1 = Merchant.create!(name: "Turing", updated_at: "2020-03-20 04:50:08 UTC")
      merchant2 = Merchant.create!(name: "Turing", updated_at: "2020-03-20 04:50:08 UTC")
      merchant3 = Merchant.create!(name: "Matteo")

      get "/api/v1/merchants/find_all?updated_at=#{merchant1.updated_at}"

      merchants = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(merchants.count).to eq(2)
      expect(merchants[0][:attributes][:id]).to eq(merchant1.id)
      expect(merchants[1][:attributes][:id]).to eq(merchant2.id)
    end

    it "can find all merchants by name and created_at" do
      merchant1 = create(:merchant, created_at: "2020-03-20 04:50:08 UTC")
      merchant2 = create(:merchant, created_at: "2020-03-20 04:50:08 UTC")

      get "/api/v1/merchants/find_all?name=#{merchant1.name.downcase}&created_at=#{merchant1.created_at}"

      merchants = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(merchants.count).to eq(2)
    end

    it "can find all merchants by name and updated_at" do
      merchant1 = create(:merchant, updated_at: "2020-03-20 04:50:08 UTC")
      merchant2 = create(:merchant, updated_at: "2020-03-20 04:50:08 UTC")

      get "/api/v1/merchants/find_all?name=#{merchant1.name.downcase}&updated_at=#{merchant1.updated_at}"

      merchants = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(merchants.count).to eq(2)
    end
  end
end
