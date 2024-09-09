# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.3'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.3', '>= 7.1.3.4'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

gem 'pry', '~> 0.14.1'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]

  # To create fake data for development & testing
  gem 'faker', '~> 3.2', '>= 3.2.1'

  # Linters
  gem 'rubocop', '~> 1.56', '>= 1.56.1', require: false
  gem 'rubocop-factory_bot', '~> 2.23'
  gem 'rubocop-rails', '~> 2.20', '>= 2.20.2', require: false
  gem 'rubocop-rspec', '~> 2.23'
end

group :development do
  gem 'letter_opener', '~> 1.8'
end
