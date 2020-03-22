class Api::V1::RevenueController < ApplicationController

  def total_revenue
    start_date = params[:start].to_time
    end_date = params[:end].to_time
    total_revenue = Merchant.total_date_revenue(start_date, end_date)
    render json: {data: {id: nil, attributes: {revenue: total_revenue}}}
  end
end
