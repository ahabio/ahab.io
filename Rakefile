require 'bundler/setup'
require 'sinatra/activerecord/rake'

$LOAD_PATH << 'lib'

require 'ahab_application'

Dir.glob('lib/tasks/**/*.rake').each do |taskfile|
  load taskfile
end
