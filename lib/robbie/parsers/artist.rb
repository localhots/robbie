module Robbie
  module Parsers
    class Artist < BaseParser
      class << self
        def find(artist_id)
          response = query("/data/v1/name/info", {
            nameid: artist_id,
            include: "discography",
            type: "main"
          })
          parse(response["name"])
        end

        def parse(data)
          return if data.nil?

          artist = parse_meta(data)
          if data["discography"] && data["discography"].is_a?(Array)
            artist.albums = data["discography"].map{ |album| Parsers::Album.parse_meta(album) }.reverse
          end
          artist
        end

        def parse_meta(data)
          return if data.nil?

          params = {}
          params[:id] = data["ids"]["nameId"] if data["ids"]
          params[:name] = data["name"]
          params[:is_group] = data["isGroup"]
          params[:genres] = data["musicGenres"].map{ |genre|
            Robbie::Genre.new(id: genre["id"], name: genre["name"])
          } if data["musicGenres"].is_a?(Array)

          Robbie::Artist.new(params)
        end
      end
    end
  end
end
