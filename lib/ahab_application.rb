require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader' if development?
require 'honeybadger'
require 'require_all'
require 'sinatra/flash'

ENV["ELASTICSEARCH_URL"] = "http://ahab.io:9200" if production?

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
    found = Asset.search params[:q] || "", :limit => limit, :offset => offset, :partial => true
    res = []
    found.each do |asset|
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

    link_uri_template = '//cdnjs.com/assets/<name>/<version>/<filename>'
    link_rel_info     = 'http://ahab.io/learn/x-asset-registry-uri'

    headers({
      'Link' => "<#{link_uri_template}>;rel=\"#{link_rel_info}\""
    })
  end

  get '/documentation' do
    self.page_title = 'Documentation'
    erb :desktop do
      erb :documentation do
        markdown :documentation
      end
    end
  end

  post '/assets' do
    @asset = initialize_asset(params[:asset])
    if @asset.save
      flash[:notice] = "#{@asset.name} was successfully saved"
      redirect '/'
    else
      #TODO: Be more specific about the error
      flash[:error] = "There was an error while saving"
      redirect '/'
    end
  end

  get '/humans.txt' do
    content_type :txt
    erb :humans
  end

  private

  def initialize_asset(params)
    asset = Asset.new(
      :name => params[:name],
      :homepage => params[:name],
      :description => params[:description]
    )
    asset.asset_versions.build(:value => params[:version])
    asset
  end
end
