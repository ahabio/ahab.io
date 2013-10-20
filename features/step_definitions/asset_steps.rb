Given(/^the following assets exist:$/) do |table|
  table.rows.each do |row|
    name, version = *row
    url = "//example.org/libraries/#{name}/#{version}"

    a = Asset.find_or_initialize_by(name: name)
    a.description ||= "#{name}: a great library"
    a.homepage ||= "http://example.com/#{name}"
    a.save!

    v = a.asset_versions.create!(value: version, url: url)
  end
end
