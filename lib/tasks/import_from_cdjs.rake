#encoding: utf-8

namespace :import do

  AssetToImport = Struct.new(:name, :homepage, :description) do
    attr_reader :versions

    def initialize(*args)
      @versions = []
      super
    end

    def url
      "http://cdnjs.com/libraries/#{name}"
    end

    def import!
      as_asset = Asset.find_by(name: name) ||
                 Asset.create!(name: name, homepage: homepage, description: description)
      versions.each { |v| v.import!(as_asset) }
    end
  end

  AssetVersionToImport = Struct.new(:version, :url) do
    def to_s
      "#{version} @ #{url}"
    end

    def import!(asset)
      AssetVersion.find_by(asset_id: asset.id, value: version) ||
      AssetVersion.create!(asset_id: asset.id, value: version, url: url)
    end
  end

  def libraries
    client = Typhoeus::Hydra.new(max_concurrency: 4)
    list_libraries.tap do |libs|
      puts "Importing #{libs.length} libraries"
      libs.each do |library|
        client.queue fetch_library_info(library)
      end
      client.run
    end
  end

  def list_libraries
    Nokogiri::HTML(Typhoeus.get('http://cdnjs.com').body).
      css('[data-library-name]').
      map { |library| AssetToImport.new(library['data-library-name']) }
  end

  def fetch_library_info(asset_to_import)
    Typhoeus::Request.new(asset_to_import.url, followlocation: true).tap do |request|
      request.on_complete do |response|
        raise "Error fetching #{asset_to_import.name}: #{response.body}" unless response.success?
        puts "#{asset_to_import.name}: fetched ✓"

        doc = Nokogiri::HTML(response.body)

        asset_to_import.homepage    = doc.css('h1 + p a').first.try(:text)
        asset_to_import.description = doc.css('h1 + p + p').first.try(:text)

        doc.css('h3').each do |h3|
          url = h3.next_element().css('.library-url').first.try(:text)
          asset_to_import.versions << AssetVersionToImport.new(h3.text, url) if url
        end
      end
    end
  end

  task :require do
    require 'typhoeus'
    require 'nokogiri'
    require 'models/asset'
    require 'models/asset_version'
  end

  desc 'Import Libraries from cdnjs.com'
  task :from_cdnjs => :require do
    libraries.each(&:import!)
  end

end