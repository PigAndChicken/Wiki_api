require_relative 'spec_helper.rb'

describe 'Test Wiki Library' do
  VCR.configure do |c|
    c.cassette_library_dir = 'spec/fixtures/cassettes'
    c.hook_into :webmock
  end
  
  # before each 'it'block, insert cassette and record new / recall old
  before do
    VCR.insert_cassette 'article', record: :new_episodes,
    match_requests_on: [:method, :uri, :headers]
  end
  
  after do
    VCR.eject_cassette
  end

  describe 'article information' do
    before do
      @article_info = WikiArticle::WikiApi.new.contents(TITLE)
    end
    
    it 'should identify pageid' do
      _(@pageid.to_i).must_be_kind_of Integer
      _(@article_info.pageid).must_equal CORRECT['pageid']
    end
    
    it 'should provide correct article title' do
      _(@article_info.title).must_equal CORRECT['title']
    end
    
    it 'should provide correct article contents' do
      _(@article_info.contents).must_equal CORRECT['contents']
    end
  end
end