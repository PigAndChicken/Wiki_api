require 'dry-struct'

module WikiArticle
  module Entity
    class Article < Dry::Struct
      attribute :pageid, Types::Strict::Int
      attribute :title, Types::Strict::String
      attribue :contents, Types::Strict::String
    end
  end
end