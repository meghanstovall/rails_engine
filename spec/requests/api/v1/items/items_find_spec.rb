require 'rails_helper'

describe 'Items API' do
  describe 'single finders' do
    it "can find an item by id" do
      new_item = create(:item)

      get "/api/v1/items/find?id=#{new_item.id}"

      item = JSON.parse(response.body, symbolize_names: true)[:data][0]

      expect(response).to be_successful
      expect(item[:attributes][:id]).to eq(new_item.id)
    end

    it "can find an item by name" do
      new_item = create(:item)

      get "/api/v1/items/find?name=#{new_item.name}"

      item = JSON.parse(response.body, symbolize_names: true)[:data][0]

      expect(response).to be_successful
      expect(item[:attributes][:name]).to eq(new_item.name)
    end

    it "can find an item by description" do
      new_item = create(:item)

      get "/api/v1/items/find?description=#{new_item.description}"

      item = JSON.parse(response.body, symbolize_names: true)[:data][0]

      expect(response).to be_successful
      expect(item[:attributes][:description]).to eq(new_item.description)
    end

    it "can find an item by unit_price" do
      new_item = create(:item)

      get "/api/v1/items/find?unit_price=#{new_item.unit_price}"

      item = JSON.parse(response.body, symbolize_names: true)[:data][0]

      expect(response).to be_successful
      expect(item[:attributes][:unit_price]).to eq(new_item.unit_price)
    end

    it "can find an item by merchant id" do
      new_item = create(:item)

      get "/api/v1/items/find?merchant_id=#{new_item.merchant.id}"

      item = JSON.parse(response.body, symbolize_names: true)[:data][0]

      expect(response).to be_successful
      expect(item[:attributes][:merchant_id]).to eq(new_item.merchant.id)
    end

    it "can find an item by created at attribute" do
      new_item = create(:item, created_at: "2020-03-20 04:50:08 UTC")

      get "/api/v1/items/find?created_at=#{new_item.created_at}"

      item = JSON.parse(response.body, symbolize_names: true)[:data][0]

      expect(response).to be_successful
      expect(item[:attributes][:id]).to eq(new_item.id)
    end

    it "can find an item by updated at attribute" do
      new_item = create(:item, updated_at: "2020-03-20 04:50:08 UTC")

      get "/api/v1/items/find?updated_at=#{new_item.updated_at}"

      item = JSON.parse(response.body, symbolize_names: true)[:data][0]

      expect(response).to be_successful
      expect(item[:attributes][:id]).to eq(new_item.id)
    end

    it "can find item by name and description" do
      new_item = create(:item)

      get "/api/v1/items/find?name=#{new_item.name.downcase}&description=#{new_item.description}"

      item = JSON.parse(response.body, symbolize_names: true)[:data][0]

      expect(response).to be_successful
      expect(item[:attributes][:name]).to eq(new_item.name)
      expect(item[:attributes][:description]).to eq(new_item.description)
    end

    it "can find item by name and merchant id" do
      new_item = create(:item)

      get "/api/v1/items/find?name=#{new_item.name.downcase}&merchant_id=#{new_item.merchant.id}"

      item = JSON.parse(response.body, symbolize_names: true)[:data][0]

      expect(response).to be_successful
      expect(item[:attributes][:name]).to eq(new_item.name)
      expect(item[:attributes][:id]).to eq(new_item.id)
    end
  end

  describe 'multiple finders' do
    it "can find all items by name" do
      merchant = create(:merchant)
      item1 = Item.create!(name: "Turing", description: "Software School", unit_price: 20.23, merchant: merchant)
      item2 = Item.create!(name: "Turing", description: "Software School", unit_price: 20.23, merchant: merchant)
      item3 = Item.create!(name: "Ring World", description: "World of Rings", unit_price: 20.23, merchant: merchant)

      get "/api/v1/items/find_all?name=#{item1.name}"

      items = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(items.count).to eq(2)
      expect(items[0][:attributes][:name]).to eq(item1.name)
      expect(items[1][:attributes][:name]).to eq(item2.name)
    end

    it "can find all items by partial name" do
      merchant = create(:merchant)
      item1 = Item.create!(name: "Turing", description: "Software School", unit_price: 20.23, merchant: merchant)
      item2 = Item.create!(name: "Ring World", description: "World of Rings", unit_price: 20.23, merchant: merchant)

      get "/api/v1/items/find_all?name=ring"

      items = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(items.count).to eq(2)
      expect(items[0][:attributes][:name]).to eq(item1.name)
      expect(items[1][:attributes][:name]).to eq(item2.name)
    end

    it "can find all items by a description" do
      merchant = create(:merchant)
      item1 = Item.create!(name: "pencil", description: "light writing utincil", unit_price: 1.23, merchant: merchant)
      item2 = Item.create!(name: "pen", description: "dark writing utincil", unit_price: 1.23, merchant: merchant)
      item3 = Item.create!(name: "hat", description: "wearable", unit_price: 15.23, merchant: merchant)
      description = "writing utincil"

      get "/api/v1/items/find_all?description=#{description}"

      items = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(items.count).to eq(2)
      expect(items[0][:attributes][:id]).to eq(item1.id)
      expect(items[1][:attributes][:id]).to eq(item2.id)
    end

    it "can find all items by a merchant id" do
      merchant = create(:merchant)
      item1 = create(:item, merchant_id: merchant.id)
      item2 = create(:item, merchant_id: merchant.id)
      item3 = create(:item, merchant_id: merchant.id)

      get "/api/v1/items/find_all?merchant_id=#{item1.merchant.id}"

      items = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(items.count).to eq(3)
      expect(items[0][:attributes][:id]).to eq(item1.id)
      expect(items[1][:attributes][:id]).to eq(item2.id)
      expect(items[2][:attributes][:id]).to eq(item3.id)
    end

    it "can find all items by a created_at" do
      merchant = create(:merchant)
      item1 = Item.create!(name: "pencil", description: "light writing utincil", unit_price: 1.23, merchant: merchant, created_at: "2020-03-20 04:50:08 UTC")
      item2 = Item.create!(name: "pen", description: "dark writing utincil", unit_price: 1.23, merchant: merchant, created_at: "2020-03-20 04:50:08 UTC")
      item3 = Item.create!(name: "hat", description: "wearable", unit_price: 15.23, merchant: merchant)

      get "/api/v1/items/find_all?created_at=#{item1.created_at}"

      items = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(items.count).to eq(2)
      expect(items[0][:attributes][:id]).to eq(item1.id)
      expect(items[1][:attributes][:id]).to eq(item2.id)
    end

    it "can find all items by a updated_at" do
      merchant = create(:merchant)
      item1 = Item.create!(name: "pencil", description: "light writing utincil", unit_price: 1.23, merchant: merchant, updated_at: "2020-03-20 04:50:08 UTC")
      item2 = Item.create!(name: "pen", description: "dark writing utincil", unit_price: 1.23, merchant: merchant, updated_at: "2020-03-20 04:50:08 UTC")
      item3 = Item.create!(name: "hat", description: "wearable", unit_price: 15.23, merchant: merchant)

      get "/api/v1/items/find_all?updated_at=#{item1.updated_at}"

      items = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(items.count).to eq(2)
      expect(items[0][:attributes][:id]).to eq(item1.id)
      expect(items[1][:attributes][:id]).to eq(item2.id)
    end

    it "can find all items by name and description" do
      merchant = create(:merchant)
      item1 = Item.create!(name: "pencil", description: "light writing utincil", unit_price: 1.23, merchant: merchant)
      item2 = Item.create!(name: "pen", description: "dark writing utincil", unit_price: 1.23, merchant: merchant)
      item3 = Item.create!(name: "hat", description: "wearable", unit_price: 15.23, merchant: merchant)

      get "/api/v1/items/find_all?name=pen&description=writing utincil"

      items = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(items.count).to eq(2)
    end
  end
end
