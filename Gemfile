source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

#####################
#####################
gem 'ransack'
#####################
#####################

gem 'roo', '~>2.1.0'
gem 'roo-xls'

gem 'devise'
gem 'devise_invitable'
gem 'bcrypt', '~> 3.1.7'
gem 'remotipart', '~> 1.2'
gem 'counter_culture', '~> 0.1.23'
gem 'rails_autolink'
gem 'backstretch-rails'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'autoprefixer-rails'
gem 'font-awesome-rails'
gem 'carrierwave'
gem 'friendly_id', '~> 5.0.0'
gem 'will_paginate', '~> 3.0.6'
gem 'rails', '~> 5.0.5'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

group :development do
  gem 'letter_opener'
  gem 'spring'
  gem 'better_errors'
  gem 'guard'
  gem 'guard-rspec', '~> 4.2.8'
end
group :development, :test do
  gem 'sqlite3'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'populator'
end
group :test do
  gem 'shoulda-matchers'
  gem 'shoulda-callback-matchers', '>=0.3.2'
end
group :production do
  gem 'pg'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

