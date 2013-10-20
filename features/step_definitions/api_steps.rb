When /^I send an OPTIONS request for "([^\"]*)"$/ do |path|
  options path
end

Then /^the response headers should include an asset URL Link$/ do
  link = last_response.headers['Link']
  assert_not_nil link, 'Expected Link headers'
  assert_match %r{rel="http://ahab.io/learn/x-asset-registry-uri"}, link
end

Then /^the response status should be (\d+)$/ do |status|
  assert_equal status.to_i, last_response.status.to_i
end
