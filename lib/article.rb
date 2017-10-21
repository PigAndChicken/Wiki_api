module WikiArticle
  class Article
    def initialize(article_info, info_source)
      @article_info = article_info
      @info_source = info_source
      @pageid = @article_info['query']['pages'].keys[0]
    end
    
    def pageid
      @pageid.to_i
    end
    
    def title
      @article_info['query']['pages'][@pageid]['title']
    end
    
    # to get content of the article
    def contents
      @article_info['query']['pages'][@pageid]['revisions'][0]['*']
    end
  end
end