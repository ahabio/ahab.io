require 'json'

namespace :assets do

  def config_path
    'ahab.json'
  end

  def asset_task(root, asset)
    url = asset['url']
    filename = File.join(root, url.split('/').last)

    file filename => config_path do |task|
      sh "curl #{url} > #{task.name}"
    end
  end

  desc 'Fetch assets from the Internet'
  task :fetch do |task|
    json = JSON.parse(File.read(config_path))
    root = json['root']

    directory(root).invoke

    json['assets'].each do |asset|
      asset_task(root, asset).invoke
    end
  end

  rule %r{^vendor\/assets} => 'assets:fetch'

end
