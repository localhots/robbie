module Robbie
  class Artist < BaseModel
    attr_accessor :id, :name, :is_group, :genres, :albums

    class << self
      def search(q)
        Parsers::Search.search(q).keep_if{ |item| item.instance_of?(Robbie::Artist) }
      end

      def find_by_name(name)
        search(name).first
      end

      def find(id)
        Parsers::Artist.find(id)
      end
    end

    def albums
      @albums ||= Parsers::Artist.find(id).albums
    end
  end
end
