When /^I send an? (\w+) request for "([^\"]*)"$/ do |method, path|
  send method.downcase, path
end

Then /^the response headers should include an asset URL Link$/ do
  link = last_response.headers['Link']
  assert_not_nil link, 'Expected Link headers'
  assert_match %r{rel="http://ahab.io/documentation/x-asset-registry-uri"}, link
end

Then /^the response status should be (\d+)$/ do |status|
  assert_equal status.to_i, last_response.status.to_i
end

Then(/^the "(.*?)" header should match "(.*?)"$/) do |name, regex|
  value = last_response.headers[name]
  assert_not_nil value, "Expected header #{name} to be set"
  assert_match Regexp.new(regex), value
end
