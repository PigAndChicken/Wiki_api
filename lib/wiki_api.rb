require 'http'
require 'addressable'

module WikiArticle
  module Wikipedia
    # Gateway class to talk to Wikipedia API
    class Api
      module Errors
        # request unauthorized
        Unauthorized = Class.new(StandardError)
        # request source not found
        NotFound = Class.new(StandardError)
      end

      # Encapsulates API response success and errors
      class Response
        HTTP_ERROR = {
          401 => Errors::Unauthorized,
          404 => Errors::NotFound
        }.freeze

        def initialize(response)
          @response = response
        end

        def successful?
          HTTP_ERROR.keys.include?(@response.code) ? false : true
        end

        def response_or_error
          successful? ? @response : raise_error(HTTP_ERROR[@response.code])
        end
      end

      def initialize; end

      # to get the data of the article
      def article_info(title)
        wiki_req_url = Api.path(URI.encode(title))
        call_wk_url(wiki_req_url).parse
      end

      def self.path(title_encoded)
        "https://en.wikipedia.org/w/api.php?action=query&prop=revisions&rvprop=content&format=json&titles=" + title_encoded
      end

      def call_wk_url(url)
        response = HTTP.headers(
          'Accept' => 'application/json').get(url)
        # return a data structure (data follows Wiki's schema)
        Response.new(response).response_or_error
      end
    end
  end
end