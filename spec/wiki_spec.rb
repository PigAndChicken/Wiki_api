require_relative 'spec_helper.rb'

describe 'Test Wiki Library' do
  API_VER = 'api/v0.1'.freeze
  CASSETTE_FILE = 'article'.freeze
  # before each 'it'block, insert cassette and record new / recall old
  before do
    VCR.insert_cassette CASSETTE_FILE,
                        record: :new_episodes,
                        match_requests_on: [:method, :uri, :headers]
  end
  
  after do
    VCR.eject_cassette
  end

  describe 'article information' do
    it 'HAPPY: should provide correct article info' do
      get "#{API_VER}/article/#{TITLE}"
      _(last_response.status).must_equal 200
      article_info = JSON.parse last_response.body
      _(article_info.title).must_equal CORRECT['title']
      _(article_info.content).must_equal CORRECT['contents']
    end

    it 'BAD: should raise exception on incorrect article' do
      get "#{API_VER}/article/bad_title"
      _(last_response.status).must_equal 404
      body = JSON.parse last_response.body
      _(body.keys).must_include 'error'
    end
  end
end