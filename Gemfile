source 'https://rubygems.org'

ruby '1.9.3'

gem 'rack', '~> 1.5.2'
gem 'redcarpet', '~> 3.0.0'
gem 'sass', '~> 3.2.12'
gem 'sinatra', '~> 1.4.3'
gem 'sinatra-contrib', '~> 1.4.1'
gem 'honeybadger', '~> 1.8.1'
gem 'activerecord', '~> 4.0.0'
gem 'sinatra-activerecord'
gem 'pg'
gem 'require_all', '~> 1.3.1'
gem 'sinatra-flash', '~> 0.3.0'

group 'assets' do
  gem 'rake', '~> 10.0'
  gem 'ahab', '~> 0.1'
end

group 'import' do
  gem 'nokogiri'
  gem 'typhoeus'
end

group 'development' do
  gem 'json'
  gem 'guard'
  gem 'guard-rake'
  gem 'pry'
end

group 'test' do
  gem 'rack-test'
  gem 'cucumber'
  gem 'minitest', '~> 4.2'
  gem 'minitest-colorize', '~> 0.0.5'
  gem 'debugger'
end

group 'deployment' do
  gem 'capistrano', '~> 2.15', require: nil
end
