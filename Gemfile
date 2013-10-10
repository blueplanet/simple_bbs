source 'https://rubygems.org'
# ruby '2.0.0'


gem 'rails', '4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 1.2'

gem 'foreman'
gem 'thin'
gem 'pg'

gem 'bootstrap-sass', github: 'thomas-mcdonald/bootstrap-sass'

gem 'kaminari'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'rspec-rails'

  gem 'factory_girl_rails'
  gem 'launchy'
end

group :development do
  gem 'spring'
  gem 'pry-rails'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'growl'
end

group :test do
  gem 'coveralls', require: false
  gem 'capybara'
  gem 'shoulda-matchers'
end

group :doc do
  gem 'sdoc', require: false
end
