# frozen_string_literal: true

Rails.logger = Logger.new($stdout)

Rails.logger.info 'Creating Categories....'
['Fast Food', 'Fruits', 'Vegetable'].each do |category_name|
  Category.create!(name: category_name, discount_percentage: rand(5.0..75.0).round(2))
end
Rails.logger.info '20 Categories created!'

Rails.logger.info 'Creating Customers....'

20.times do
  Customer.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number
  )
end

Rails.logger.info '20 Customers created!'

Rails.logger.info 'Creating Items....'

20.times do
  Item.create!(
    category_id: Category.last.id,
    name: Faker::Food.dish,
    quantity: rand(0..10),
    price: rand(1.0..500.0).round(2),
    tax_rate: rand(1.0..18.0).round(2),
    discount_percentage: rand(0.0..75.0).round(2)
  )
end

Rails.logger.info '20 Items created!'
