When /^I send an OPTIONS request for "([^\"]*)"$/ do |path|
  options path
end

Then /^the response headers should include an asset URL Link$/ do
  links = last_response.headers['Link']
  assert_not_nil links, 'Expected Link headers'
  assert links.length > 1
end

Then /^the response status should be (\d+)$/ do |status|
  assert_equal status.to_i, last_response.status.to_i
end
