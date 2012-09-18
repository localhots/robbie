module Robbie
  module Parsers
    class Album < BaseParser
      class << self
        def find(album_id)
          response = query("/data/v1/album/info", {
            albumid: album_id,
            include: "tracks"
          })
          parse(response["album"])
        end

        def parse(data)
          return if data.nil?

          album = parse_meta(data)
          if data["tracks"].is_a?(Array)
            current_disc = 0
            position = 0
            album.tracks = data["tracks"].map do |track|
              if track["disc"] && track["disc"] != current_disc
                position = 0
                current_disc = track["disc"]
              end
              position += 1

              Parsers::Track.parse_meta(track, current_disc, position)
            end
          else
            album.tracks = []
          end
          album
        end

        def parse_meta(data)
          return if data.nil?

          params = {}
          params[:id] = data["ids"]["albumId"] if data["ids"]
          params[:title] = data["title"]
          if data["originalReleaseDate"].is_a?(String)
            params[:year] = data["originalReleaseDate"].split("-").first
          elsif data["year"].is_a?(String)
            params[:year] = data["year"].split("-").first
          end

          Robbie::Album.new(params)
        end
      end
    end
  end
end
