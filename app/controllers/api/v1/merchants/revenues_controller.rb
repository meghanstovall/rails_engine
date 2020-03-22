class Api::V1::Merchants::RevenuesController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity]))
  end

  def most_items
    render json: MerchantSerializer.new(Merchant.most_items(params[:quantity]))
  end

  def total_revenue
    start_date = params[:start].to_date
    end_date = params[:end].to_date
    total_revenue = Merchant.total_date_revenue(start_date, end_date)
    render json: {data: {id: nil, attributes: {revenue: total_revenue}}}
  end

  def show
    revenue_num = Merchant.merchant_revenue(params[:id].to_i)
    render json: {data: {id: params[:id].to_i, attributes: {revenue: revenue_num}}}
  end
end
