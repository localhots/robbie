module Robbie
  module Parsers
    class Search < BaseParser
      class << self
        def search(q)
          response = query("/search/v2.1/music/search", {
            query: q.gsub(/\s| |%20/, "+"),
            entitytype: "artist&entitytype=album"
          })
          parse(response["searchResponse"]["results"])
        end

        def single_stage_search(q)
          response = query("/search/v2.1/music/singlestagesearch", {
            query: q.gsub(/\s| |%20/, "+"),
            entitytype: "artist&entitytype=album",
            size: 10
          })
          parse(response["searchResponse"]["results"])
        end

        def autocomplete(q)
          response = query("/search/v2/music/autocomplete", {
            query: q.gsub(/\s| |%20/, "+"),
            entitytype: "artist&entitytype=album",
            size: 10
          })
          response["autocompleteResponse"]["results"]
        end

        def parse(data)
          return if data.nil?

          data.map do |result|
            if result["type"] == "artist"
              Parsers::Artist.parse_meta(result["name"])
            elsif result["type"] == "album"
              Parsers::Album.parse_meta(result["album"])
            end
          end
        end
      end
    end
  end
end
