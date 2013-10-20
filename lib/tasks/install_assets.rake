require 'json'
require 'ahab/fetch_task'

namespace :assets do

  Ahab::FetchTask.new(:fetch)

end
