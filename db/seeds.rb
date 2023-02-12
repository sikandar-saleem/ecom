# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create(name: 'Fruit')
Category.create(name: 'Fast Food')
Category.create(name: 'Chicken')
Category.create(name: 'Shakes')

# User.create('Sikandar', 'sikandar.saleem@devsinc.com', 'sikandarsaleem', '112233', '112233')
# User.create('Hamza', 'hamza.latif@devsinc.com', 'hamzalatif', '112233', '112233')
User.create!(
  full_name: 'Admin',
  email: 'admin@devsinc.com',
  username: 'Admin',
  role: 'admin',
  password: '112233'
)
