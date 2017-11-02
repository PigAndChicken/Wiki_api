module WikiArticle
  module Wikipedia
    # data mapper object for Wikipedia's articles
    class ArticleMapper
      # initialize with gateway object
      def initialize(gateway)
        @gateway = gateway
      end

      # load data from gateway object
      def load(title)
        article_info = @gateway.article_info(title)
        build_entity(article_info)
      end

      # build entity object with loaded data structure
      def build_entity(article_info)
        DataMapper.new(article_info).build_entity
      end

      # map/parse Wiki's data schema to domain entity's data schema
      class DataMapper
        def initialize(article_info)
          @article_info = article_info
          @pageid = @article_info['query']['pages'].keys[0]
        end

        # make new entity object, and extract specific elements from data structure to this new entity object
        def build_entity
          Entity::Article.new(
            pageid: pageid,
            title: title,
            contents: contents
          )
        end

        def pageid
          @pageid.to_i
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