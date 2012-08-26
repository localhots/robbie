module Robbie
  class Album < BaseModel
    attr_accessor :id, :title, :year, :tracks

    class << self
      def search(q)
        Parsers::Search.search(q).keep_if{ |item| item.instance_of?(Robbie::Album) }
      end

      def find(id)
        Parsers::Album.find(id)
      end
    end

    def tracks
      @tracks ||= Parsers::Album.find(id).tracks || []
    end
  end
end
