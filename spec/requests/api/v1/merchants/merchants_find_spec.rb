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

    # it "can find a merchant by created at attribute" do
    #   new_merchant = create(:merchant)
    #
    #   get "/api/v1/merchants/find?created_at=#{new_merchant.created_at}"
    #
    #   merchant = JSON.parse(response.body, symbolize_names: true)[:data][0]
    #
    #   expect(response).to be_successful
    #   expect(merchant[:attributes][:created_at]).to eq(new_merchant.created_at)
    # end
    #
    # it "can find a merchant by updated at attribute" do
    #   new_merchant = create(:merchant)
    #
    #   get "/api/v1/merchants/find?updated_at=#{new_merchant.updated_at}"
    #
    #   merchant = JSON.parse(response.body, symbolize_names: true)[:data][0]
    #
    #   expect(response).to be_successful
    #   expect(merchant[:attributes][:updated_at]).to eq(new_merchant.updated_at)
    # end
  end

  describe 'multiple finders' do
  end
end
