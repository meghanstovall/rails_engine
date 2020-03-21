class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def convert_price
    unit_price / 100.to_f
  end

  def self.single_search(search_params)
    if search_params[:name] || search_params[:description]
      attribute = search_params.keys.first
      Item.where("lower(#{attribute}) = ?", search_params[attribute.to_sym].downcase).limit(1)
    else
      Item.where(search_params).limit(1)
    end
  end

  def self.multi_search(search_params)
    if search_params[:name]
      Item.where('name ILIKE ? ', "%#{search_params[:name]}%")
    elsif search_params[:description]
      Item.where('description ILIKE ? ', "%#{search_params[:description]}%")
    else
      Item.where(search_params)
    end
  end
end
