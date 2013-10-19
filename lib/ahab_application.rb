require 'sinatra'

class AhabApplication < Sinatra::Base
  set(:project_root)  { File.expand_path('../../', __FILE__) }
  set(:public_folder) { File.join(project_root, 'public') }
  set(:css_dir)       { public_folder }

  get '/' do
    erb :index
  end
end
