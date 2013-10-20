require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader' if development?
require 'honeybadger'
require 'require_all'
require 'sinatra/flash'

class AhabApplication < Sinatra::Base
  enable    :sessions
  register  Sinatra::ActiveRecordExtension
  register  Sinatra::Flash

  require_all 'lib/models'
  require_all 'lib/helpers'

  set(:project_root)  { File.expand_path('../../', __FILE__) }
  set(:public_folder) { File.join(project_root, 'public') }
  set :database_file, File.join(project_root, 'config/database.yml')
  set(:css_dir)       { public_folder }

  set :static_cache_control, [ :public, :max_age => 300 ]

  configure :development do
    register Sinatra::Reloader
  end

  Honeybadger.configure do |config|
    config.api_key = ENV['HONEYBADGER_API_KEY']
  end

  use Honeybadger::Rack

  helpers AssetHelpers
  helpers TitleHelper
  helpers IndexHelper

  get '/' do
    no_header_title!
    erb :index, layout: :desktop
  end

  get '/search.json' do
    content_type :json
    offset = params[:offset] || 0
    limit = params[:limit] || 40
    query = params[:q] || ""
    assets = Asset.where("name like ?", "%#{query}%").limit(limit).offset(offset)
    res = []
    assets.each do |asset|
      hash = {}.tap do |h|
        h['name'] = asset.name
        h['homepage'] = asset.homepage
        h['description'] = asset.description
        h['version'] = asset.optimistic_version
      end
      res << hash
    end
    res.to_json
  end

  options '/' do
    body ''
    status 204

    link_uri_template = '//cdnjs.com/assets/<name>/<version>'
    link_rel_info     = 'http://ahab.io/learn/x-asset-registry-uri'

    headers({
      'Link' => "<#{link_uri_template}>;rel=\"#{link_rel_info}\""
    })
  end

  get '/documentation' do
    redirect '/documentation/overview'
  end

  get '/documentation/:page' do
    begin
      self.page_title = 'Documentation'
      erb :desktop do
        erb :documentation do
          markdown "documentation_#{params[:page]}".to_sym
        end
      end
    rescue Errno::ENOENT
      pass
    end
  end

  get '/assets/:name/:version' do
    asset = Asset.find_by name: params[:name]
    raise Sinatra::NotFound unless asset
    version = asset.optimistic_version params[:version]
    asset_version = asset.asset_versions.find_by value: version
    raise Sinatra::NotFound unless asset_version
    redirect asset_version.url, 302
  end

  post '/assets' do
    @asset = initialize_asset(params[:asset])
    if @asset.save
      flash[:notice] = "#{@asset.name} was successfully saved"
      redirect '/'
    else
      flash[:error] = "There was an error while saving: </br>" << @asset.errors.full_messages.join("</br>")
      redirect '/'
    end
  end

  get '/humans.txt' do
    content_type :txt
    erb :humans
  end

  not_found do
    status 404
    erb :not_found, layout: :desktop
  end

  error Asset::NoVersionAvailable do
    raise Sinatra::NotFound
  end

  private

  def initialize_asset(params)
    asset = Asset.find_or_initialize_by(name: params[:name])
    asset.description = params[:description]
    asset.asset_versions.build(
      :value => params[:version],
      :url   => params[:url]
    )
    asset
  end
end
