ENV['RACK_ENV'] = 'test'
$LOAD_PATH << 'lib'

require 'rack/test'
require 'ahab_application'

module ApiSupport
  include Rack::Test::Methods

  def app
    AhabApplication.new
  end
end

World(ApiSupport)

Before do
  AssetVersion.destroy_all
  Asset.destroy_all
end