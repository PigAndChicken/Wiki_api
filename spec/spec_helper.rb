require 'http'
require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'
include WebMock::API
WebMock.enable!

require_relative '../lib/wiki_api.rb'

TITLE = "Service-oriented architecture"
CORRECT = YAML.safe_load(File.read('spec/fixtures/wk_results.yml'))