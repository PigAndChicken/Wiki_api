require 'roda'
require 'econfig'
require_relative 'lib/init.rb'

module WikiArticle
  # my own API using Roda web framework
  class Api < Roda
    plugin :environments
    plugin :json
    plugin :halt
    
    # to easily check ENV['RACK_ENV']
    extend Econfig::Shortcut
    Econfig.env = environment.to_s
    Econfig.root = '.'
    
    route do |routing|
      app = Wikiapi

      # GET / request
      routing.root do
        { 'message' => "WikiArticle API up in #{app.environment}" }
      end
      
      routing.on 'api' do
        # /api/vo.1 branch
        routing.on 'v0.1' do
          # /api/v0.1/:title branch
          routing.on 'article', String do |title|
            wiki_api = Wikipedia::Wikiapi.new
            article_mapper = Wikipedia::ArticleMapper.new(wiki_api)
            begin
              article = article_mapper.load(title)
            rescue StandardError
              routing.halt(404, error: 'Article not found')
            end

            # GET /api/v0.1/:title request
            routing.is do
              { article: { title: article.title,
                           content: article.contents } }
            end
          end
        end
      end
    end
  end
end