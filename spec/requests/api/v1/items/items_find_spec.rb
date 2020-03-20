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

    # it "can find an item by created at attribute" do
    #   new_item = create(:item)
    #
    #   get "/api/v1/items/find?created_at=#{new_item.created_at}"
    #
    #   item = JSON.parse(response.body, symbolize_names: true)[:data][0]
    #
    #   expect(response).to be_successful
    #   expect(item[:attributes][:created_at]).to eq(new_item.created_at)
    # end
    #
    # it "can find an item by updated at attribute" do
    #   new_item = create(:item)
    #
    #   get "/api/v1/items/find?updated_at=#{new_item.updated_at}"
    #
    #   item = JSON.parse(response.body, symbolize_names: true)[:data][0]
    #
    #   expect(response).to be_successful
    #   expect(item[:attributes][:updated_at]).to eq(new_item.updated_at)
    # end
  end

  describe 'multiple finders' do
  end
end
