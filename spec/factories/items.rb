FactoryBot.define do
  factory :item do
    name {"Banana Stand"}
    description {"There's always a money in the banana stand."}
    unit_price {751.07}
    merchant {Merchant.create({name: "Williams and Sons"})}
  end
end
