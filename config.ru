require 'rack/file'

use Rack::Static, :urls => ["/images", "/js", "/css"],
                  :root => "public",
                  :index => 'index.html'
run Rack::File.new('public')
