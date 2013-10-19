require 'bundler/setup'
require 'sinatra/activerecord/rake'
require './lib/ahab_application'

Dir.glob('lib/tasks/**/*.rake').each do |taskfile|
  load taskfile
end
