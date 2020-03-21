class Api::V1::Merchants::SearchController < ApplicationController
  def show
    # render json: MerchantSerializer.new(Merchant.where(request.query_parameters))

    if search_params[:name]
      attribute = search_params.keys.first
      render json: MerchantSerializer.new(Merchant.where("lower(#{attribute}) = ?", search_params[attribute.to_sym].downcase))
    else
      render json: MerchantSerializer.new(Merchant.where(search_params))
    end
  end

  def index
    if search_params[:name]
      render json: MerchantSerializer.new(Merchant.where('name ILIKE ? ', "%#{search_params[:name]}%"))
    else
      render json: MerchantSerializer.new(Merchant.where(search_params))
    end
  end

  private
    def search_params
      params.permit(:id, :name, :created_at, :updated_at)
    end
end
