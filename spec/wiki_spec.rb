require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '../lib/wiki_api.rb'

describe 'Test Wiki Library' do
  TITLE = "Service-oriented architecture"
  CORRECT = YAML.safe_load(File.read('spec/fixtures/wk_results.yml'))

  describe 'Article Contents' do
    it 'should provide correct article contents' do
      article_info = WikiArticle::WikiApi.new.contents(TITLE)
      _(article_info.pageid).must_equal CORRECT['pageid']
      _(article_info.title).must_equal CORRECT['title']
      _(article_info.contents).must_equal CORRECT['contents']
    end
  end
end