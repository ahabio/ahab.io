ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'minitest/colorize'
require 'minitest/spec'
require 'rack/test'

require File.expand_path '../../lib/ahab_application.rb', __FILE__
