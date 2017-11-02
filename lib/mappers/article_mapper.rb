module WikiArticle
  module Wikipedia
    # Data mapper's entity object for Wikipedia's article
    class ArticleMapper
      # initialize with gateway object
      def initialize(gateway)
        @gateway = gateway
      end

      # load data from gateway objectW
      def load(title)
        article_info = @gateway.article_info(URI.encode(title))
        build_entity(article_info)
      end

      # build entity object from loaded data structure
      def build_entity(article_info)
        DataMapper.new(article_info).build_entity
      end

      # map/parse Wiki's data schema to domain entity's data schema
      class DataMapper
        def initialize(article_info)
          @article_info = article_info
          @pageid = @article_info['query']['pages'].keys[0]
        end

        # make new entity object, and extract specific elements from data structure
        def build_entity
          Entity::Article.new(
            title: title,
            contents: contents
          )
        end

        def title
          @article_info['query']['pages'][@pageid]['title']
        end

        def contents
          @article_info['query']['pages'][@pageid]['revisions'][0]['*']
        end
      end
    end
  end
end