source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.7"

gem "rails", "~> 5.2.8", ">= 5.2.8.1"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "rack-cors"
gem "rack-attack"
gem "friendly_id", "~> 5.5"
gem "devise_token_auth", "~> 1.1.4"

gem "bootsnap", ">= 1.1.0", require: false

group :development, :test do
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails", "~> 5.1", ">= 5.1.1"
  gem "shoulda-matchers", "~> 4.0"
  gem "rufo"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end
