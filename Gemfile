source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.2"

gem "rails", "~> 5.2.3"
gem "net-sftp"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "sass-rails", "~> 5.0"
gem "sidekiq"
gem "simple_form"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"

gem "bootsnap", ">= 1.1.0", require: false

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "shoulda-matchers"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "chromedriver-helper"
  gem "faker"
  gem "rspec-rails"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
