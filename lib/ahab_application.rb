require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/assetpack'
require 'sinatra/reloader' if development?
require 'honeybadger'
require 'require_all'

class AhabApplication < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  register Sinatra::AssetPack

  require_all 'lib/models'

  set :root,          File.expand_path('../../', __FILE__)
  set :public_folder, 'public'
  set :database_file, File.join(root, 'config/database.yml')
  set :css_dir,       'public'
  set :views,         'lib/views'

  assets {
    serve '/assets/app/',    from: 'lib/assets'
    serve '/assets/vendor/', from: 'vendor/assets'

    css :vendor, '/assets/vendor/vendor.css', [
      '**/*.css'
    ]

    css :application, '/assets/app/application.css', [
      'application.css'
    ]
  }

  configure :development do
    register Sinatra::Reloader
  end

  Honeybadger.configure do |config|
    config.api_key = ENV['HONEYBADGER_API_KEY']
  end

  use Honeybadger::Rack

  get '/' do
    erb :index, layout: :desktop
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
