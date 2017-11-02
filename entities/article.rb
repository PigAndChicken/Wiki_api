require 'dry-struct'

module WikiArticle
  module Entity
    class Article < Dry::Struct
      attribute :title, Types::Strict::String
      attribute :content, Types::Strict::String
    end
  end
end