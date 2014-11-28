source 'https://rubygems.org'
ruby '2.1.5'

gem 'rails', '4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 1.2'
gem 'slim-rails'

gem 'foreman'
gem 'puma'
gem 'pg'

gem 'bootstrap-sass', github: 'thomas-mcdonald/bootstrap-sass'

gem 'kaminari'
gem 'devise'
gem 'devise-i18n-views'

gem 'redcarpet'

group :production do
  gem 'rails_12factor'
  gem 'newrelic_rpm'
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
  gem 'faker'
end

group :doc do
  gem 'sdoc', require: false
end
