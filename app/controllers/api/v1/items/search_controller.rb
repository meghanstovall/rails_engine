class Api::V1::Items::SearchController < ApplicationController
  def show
    # render json: ItemSerializer.new(Item.where(request.query_parameters))

    if search_params[:name] || search_params[:description]
      attribute = search_params.keys.first
      render json: ItemSerializer.new(Item.where("lower(#{attribute}) = ?", search_params[attribute.to_sym].downcase))
    else
      render json: ItemSerializer.new(Item.where(search_params))
    end
  end

  def index
    if search_params[:name]
      render json: ItemSerializer.new(Item.where('name ILIKE ? ', "%#{search_params[:name]}%"))
    elsif search_params[:description]
      render json: ItemSerializer.new(Item.where('description ILIKE ? ', "%#{search_params[:description]}%"))
    else
      render json: ItemSerializer.new(Item.where(search_params))
    end
  end

  private
    def search_params
      params.permit(:id, :name, :description, :merchant_id, :unit_price, :created_at, :updated_at)
    end
end
