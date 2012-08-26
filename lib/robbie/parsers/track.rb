module Robbie
  module Parsers
    class Track < BaseParser
      class << self
        def find(track_id)
          response = query("/data/v1/song/info", {
            trackid: track_id
          })

          parse_meta(response["song"])
        end

        def parse_meta(data, disc = nil, position = nil)
          return if data.nil?

          params = {}
          params[:id] = data["ids"]["trackId"] if data["ids"]
          params[:disc_id] = disc
          params[:position] = position
          params[:artists] = data["performers"].map{ |performer|
            Robbie::Artist.new(id: performer["id"], name: performer["name"])
          } if data["performers"].is_a?(Array)
          params[:artists] = data["primaryArtists"].map{ |artist|
            Robbie::Artist.new(id: artist["id"], name: artist["name"])
          } if data["primaryArtists"].is_a?(Array)
          params[:title] = data["title"]
          params[:duration] = data["duration"]

          Robbie::Track.new(params)
        end
      end
    end
  end
end
