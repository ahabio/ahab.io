require 'json'

namespace :assets do

  def fetch_asset(root, asset)
    url = asset['url']
    filename = File.join(root, url.split('/').last)
    sh "curl #{url} > #{filename}"
  end

  task :fetch do
    json = JSON.parse(File.read('ahab.json'))
    root = json['root']
    json['assets'].each { |asset| fetch_asset(root, asset) }
  end

end