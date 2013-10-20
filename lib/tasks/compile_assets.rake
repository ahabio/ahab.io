namespace :assets do

  desc 'Compile assets to public/'
  task :compile do
    Object.send :const_set, :APP_FILE, 'lib/ahab_application.rb'
    Object.send :const_set, :APP_CLASS, 'AhabApplication'
    require 'sinatra/assetpack/rake'
    Rake::Task['assetpack:build'].invoke
  end

end