class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  has_many :items
  has_many :invoices
  attributes :id, :name

  attribute :num_items do |object|
    object.items.count
  end

  attribute :num_invoices do |object|
    object.invoices.count
  end
end
