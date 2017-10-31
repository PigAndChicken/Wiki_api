ENV['RACK_ENV'] = 'test'

require 'http'
require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'
include WebMock::API
WebMock.enable!

require 'simplecov'
SimpleCov.start

require_relative 'test_load_all'

require_relative '../lib/wiki_api.rb'

TITLE = "Service-oriented architecture"
CORRECT = YAML.safe_load(File.read('spec/fixtures/wk_results.yml'))
CASSETTES_FOLDER = 'spec/fixtures/cassettes'.freeze

VCR.configure do |c|
  c.cassette_library_dir = CASSETTES_FOLDER
  c.hook_into :webmock
end