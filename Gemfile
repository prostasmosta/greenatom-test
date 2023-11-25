source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'bcrypt', '~> 3.1.7'

gem 'bootsnap', require: false

gem 'pg', '>= 0.18', '< 2.0'

gem 'puma', '~> 5.0'

gem 'rails', '~> 7.0.8'

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development do
  gem 'rubocop', require: false
end

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails', '~> 6.0'
end

group :test do
  gem 'shoulda-matchers', '~> 5.0'
end
