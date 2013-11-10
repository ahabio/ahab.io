require 'bundler/setup'
require 'sinatra/activerecord/rake'

$LOAD_PATH << 'lib'

Dir.glob('lib/tasks/**/*.rake').each do |taskfile|
  load taskfile
end
