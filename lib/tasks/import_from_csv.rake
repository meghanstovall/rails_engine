require 'csv'

task :import_from_csv => :environment do

  puts "Importing Customers"

  customers = CSV.read("./db/data/customers.csv", headers: true, header_converters: :symbol)
  customers.each do |customer|
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    Customer.create!(customer.to_h)
  end

  puts "Importing Merchants"

  merchants = CSV.read("./db/data/merchants.csv", headers: true, header_converters: :symbol)
  merchants.each do |merchant|
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    Merchant.create!(merchant.to_h)
  end

  ActiveRecord::Base.connection.execute('ALTER SEQUENCE merchants_id_seq RESTART WITH 101')

  puts "Importing Items"

  items = CSV.read("./db/data/items.csv", headers: true, header_converters: :symbol)
  items.each do |item|
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    new_item = Item.new(item.to_h)
    new_item.unit_price = new_item.convert_price
    new_item.save
  end

  ActiveRecord::Base.connection.execute('ALTER SEQUENCE items_id_seq RESTART WITH 2484')

  puts "Importing Invoices"

  invoices = CSV.read("./db/data/invoices.csv", headers: true, header_converters: :symbol)
  invoices.each do |invoice|
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    Invoice.create!(invoice.to_h)
  end

  puts "Importing Invoice Items"

  invoice_items = CSV.read("./db/data/invoice_items.csv", headers: true, header_converters: :symbol)
  invoice_items.each do |invoiceitem|
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
    invoice_item = InvoiceItem.new(invoiceitem.to_h)
    invoice_item.unit_price = invoice_item.convert_price
    invoice_item.save
  end

  puts "Importing Transactions"

  transactions = CSV.read("./db/data/transactions.csv", headers: true, header_converters: :symbol)
  transactions.each do |transaction|
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
    Transaction.create!(transaction.to_h)
  end
end
