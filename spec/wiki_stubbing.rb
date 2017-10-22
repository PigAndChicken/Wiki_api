require 'http'
require 'yaml'
require 'webmock'
require WebMock::API
WebMock.enable!

CORRECT = YAML.safe_load(File.read('../wiki_api/spec/fixtures/wk_results.yml')

wiki_url = "https://en.wikipedia.org/w/api.php?action=query&prop=revisions&rvprop=content&format=json&titles=service-oriented%20architecture"

WebMock::stub_request(:get, wiki_url).with(
  headers: {
    'Accept' => 'application/json'
}).to_return(
  status: 200,
  body: CORRECT.to_json
)

response = HTTP.get(
  wiki_url,
  headers: { 'Accept' => 'application/json' })

puts response.status

puts response.body.to_s
