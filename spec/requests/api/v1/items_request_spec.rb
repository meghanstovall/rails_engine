require 'rails_helper'

describe 'Items API' do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)["data"]
    expect(items.count).to eq(3)
  end

  it "can get one item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item["attributes"]["id"]).to eq(id)
  end

  # it "can create a new item" do
  #   item_params = {name: "Saw", description: "I want to play a game", unit_price: 25}
  #
  #   post "/api/v1/items", params: {item: item_params}
  #   item = Item.last
  #
  #   expect(response).to be_successful
  #   expect(item.name).to eq(item_params[:name])
  # end
end
