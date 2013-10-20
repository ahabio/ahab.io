require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader' if development?
require 'honeybadger'
require 'require_all'

class AhabApplication < Sinatra::Base

  use Rack::ConditionalGet
  use Rack::ETag

  register Sinatra::ActiveRecordExtension
  require_all 'lib/models'

  set(:project_root)  { File.expand_path('../../', __FILE__) }
  set(:public_folder) { File.join(project_root, 'public') }
  set :database_file, File.join(project_root, 'config/database.yml')
  set(:css_dir)       { public_folder }

  configure :development do
    register Sinatra::Reloader
  end

  Honeybadger.configure do |config|
    config.api_key = ENV['HONEYBADGER_API_KEY']
  end

  use Honeybadger::Rack

  get '/' do
    erb :index
  end

  options '/' do
    body ''
    status 204

    link_uri_template = '//cdnjs.com/assets/<name>/<version>/<filename>'
    link_rel_info     = 'http://ahab.io/learn/x-asset-registry-uri'

    headers({
      'Link' => "<#{link_uri_template}>;rel=\"#{link_rel_info}\""
    })
  end

  get '/humans.txt' do
    content_type :txt
    erb :humans
  end
end
