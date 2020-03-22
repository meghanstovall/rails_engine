class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.single_search(search_params)
    if search_params[:name]
      attribute = search_params.keys.first
      Merchant.where("lower(#{attribute}) = ?", search_params[attribute.to_sym].downcase).limit(1)
    else
      Merchant.where(search_params).limit(1)
    end
  end

  def self.multi_search(search_params)
    if search_params[:name]
      Merchant.where('name ILIKE ? ', "%#{search_params[:name]}%")
    else
      Merchant.where(search_params)
    end
  end

  def self.most_revenue(limit_num)
    joins(:transactions, :invoice_items).where(transactions: {result: "success"})
      .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .group(:id).order('revenue DESC').limit(limit_num.to_i)
  end
end
