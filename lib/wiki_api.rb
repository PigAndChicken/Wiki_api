require 'http'
require 'addressable'
require_relative 'article.rb'

module WikiArticle
  module Wikipedia
    # Gateway class to talk to Wikipedia API
    class WikiApi
      module Errors
        # request unauthorized
        Unauthorized = Class.new(StandardError)
        # request source not found
        NotFound = Class.new(StandardError)
      end

      class Response
        HTTP_ERROR = {
          401 => Errors::Unauthorized,
          404 => Errors::NotFound
        }.freeze

        def initialize(response)
          @response = response
        end

        def successful?
          HTTP_ERROR.include?(@response.code) ? false : true
        end

        def response_or_error
          successful? ? @response : raise_error(HTTP_ERROR[@response.code])
        end
      end


      def initialize; end

      # to get contents of the article
      def contents(title)
        wiki_req_url = WikiApi.path(URI.encode(title))
        article_info = call_wk_url(wiki_req_url).parse
        Article.new(article_info, self)
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