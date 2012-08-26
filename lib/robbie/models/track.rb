module Robbie
  class Track < BaseModel
    attr_accessor :id, :disc_id, :position, :artists, :title, :duration

    class << self
      def find(id)
        Parsers::Track.find(id)
      end
    end

    def artists
      @artists || []
    end
  end
end
