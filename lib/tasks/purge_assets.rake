namespace :assets do

  def purge_request(asset, &on_purged)
    url = asset.sub('public', 'http://assets.ahab.io')
    Typhoeus::Request.new(url, :method => :purge).tap do |request|
      request.on_complete(&on_purged)
    end
  end

  def purge_assets(assets)
    [].tap do |failed|
      Typhoeus::Hydra.hydra.tap do |client|
        assets.each do |asset|
          request = purge_request(asset) do |response|
            failed << asset unless response.success?
          end
          client.queue request
        end

        client.run
      end
    end
  end

  desc 'Purge assets from the CDN'
  task :purge => :compile do
    require 'typhoeus'
    failed = purge_assets( Dir['public/**/*.*'] )
    if failed.any?
      abort "Failed to purge #{failed.join(', ')}"
    else
      puts "Purged assets"
    end
  end

end