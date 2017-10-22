require 'http'
require 'vcr'

# folder(cassettes) to store recordings in
# webmock (stubbing library to use)
VCR.configure do |c|
  c.cassette_library_dir = 'cassettes'
  c.hook_into :webmock
end

# cassettes: store tests in yaml file
# create a cassette named 'artical'
# new_episode: Record new interactions, reply old ones
VCR.insert_cassette 'article', record: :new_episodes

github_url = "https://en.wikipedia.org/w/api.php?action=query&prop=revisions&rvprop=content&format=json&titles=service-oriented%20architecture"

response = HTTP.get(
  github_url,
  headers: {
    'Accept' => 'application/json' })
    
puts response.status
puts response.body.to_s

# save interactions to cassette, stop recording (but re-inserting is possible)
VCR.eject_cassette