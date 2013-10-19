require 'sinatra'
require "sinatra/reloader" if development?

class AhabApplication < Sinatra::Base
  set(:project_root)  { File.expand_path('../../', __FILE__) }
  set(:public_folder) { File.join(project_root, 'public') }
  set(:css_dir)       { public_folder }

  configure :development do
    register Sinatra::Reloader
  end

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
end
