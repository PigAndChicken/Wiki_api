module WikiArticle
  module Entity
    # Domain entity object for any git repos
    class Article < Dry::Struct
      attribute :pageid, Types::Strict::Int
      attribute :title, Types::Strict::String
      attribue :contents, Types::Strict::String
    end
  end
end