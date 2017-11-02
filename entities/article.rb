require 'dry-struct'

module WikiArticle
  module Entity
    class Article < Dry::Struct
      attribute :title, Types::Strict::String
      attribute :contents, Types::Strict::String
    end
  end
end