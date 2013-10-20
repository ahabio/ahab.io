namespace :import do

  AssetToImport = Struct.new(:name, :description) do
    attr_reader :versions

    def initialize(*args)
      @versions = []
      super
    end

    def url
      "http://cdnjs.com/libraries/#{name}"
    end
  end

  AssetVersionToImport = Struct.new(:version, :url) do
    def to_s
      "#{version} @ #{url}"
    end
  end

  def libraries
    client = Typhoeus::Hydra.new(max_concurrency: 4)
    list_libraries.tap do |libs|
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
      .slice(22, 3) # TODO: get all of them
  end

  def fetch_library_info(asset_to_import)
    Typhoeus::Request.new(asset_to_import.url, followlocation: true).tap do |request|
      request.on_complete do |response|
        raise "Error fetching #{asset_to_import.name}: #{response.body}" unless response.success?

        doc = Nokogiri::HTML(response.body)

        asset_to_import.description = doc.css('h1 + p + p').text

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
    libraries.each do |lib_to_import|
      # TODO: import them into the DB
      puts lib_to_import.name
      puts lib_to_import.description
      lib_to_import.versions.each { |v| puts v }
      puts ''
    end
  end

end