require 'http'
require 'yaml'
require 'addressable'
 # get addressable/uri to encode uri

def wk_api_path(title)
  "https://en.wikipedia.org/w/api.php?action=query&prop=revisions&rvprop=content&format=json&titles=" + title
end

def call_wk_url(url)
  HTTP.headers(
    'Accept' => 'application/json',
  ).get(url)
end

wk_response = {}
wk_results = {}

url = wk_api_path(URI.encode("Service-oriented architecture"))
  # => "https://en.wikipedia...Service-oriented%20architecture"
wk_response[url] = call_wk_url(url)
articles = wk_response[url].parse

pageid = articles['query']['pages'].keys[0]
wk_results['pageid'] = articles['query']['pages'][pageid]['pageid']
wk_results['title'] = articles['query']['pages'][pageid]['title']
wk_results['contents'] = articles['query']['pages'][pageid]['revisions'][0]["*"]

File.write('spec/fixtures/wk_response.yml', wk_response.to_yaml)
File.write('spec/fixtures/wk_results.yml', wk_results.to_yaml)