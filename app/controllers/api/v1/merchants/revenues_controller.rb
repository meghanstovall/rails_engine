class Api::V1::Merchants::RevenuesController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity]))
  end

  def show
    revenue_num = Merchant.merchant_revenue(params[:id].to_i)
    render json: {data: {id: params[:id].to_i, attributes: {revenue: revenue_num}}}
  end

  def most_items
    render json: MerchantSerializer.new(Merchant.most_items(params[:quantity]))
  end
end
