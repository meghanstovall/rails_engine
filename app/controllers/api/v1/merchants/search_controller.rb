class Api::V1::Merchants::SearchController < ApplicationController
  def show
    if search_params[:name]
      render json: MerchantSerializer.new(Merchant.where("lower(name) = ?", search_params[:name].downcase))
    else
      render json: MerchantSerializer.new(Merchant.where(search_params))
    end
  end

  private
    def search_params
      params.permit(:id, :name, :created_at, :updated_at)
    end
end
