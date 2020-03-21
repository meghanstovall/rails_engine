class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.single_search(search_params))
  end

  def index
    render json: ItemSerializer.new(Item.multi_search(search_params))
  end

  private
    def search_params
      params.permit(:id, :name, :description, :merchant_id, :unit_price, :created_at, :updated_at)
    end
end
