require "digest/md5"
require "httparty"
require "oj"
require "multi_json"

require "robbie/version"
require "robbie/parsers/base_parser"
require "robbie/parsers/search"
require "robbie/parsers/artist"
require "robbie/parsers/album"
require "robbie/parsers/track"
require "robbie/models/base_model"
require "robbie/models/artist"
require "robbie/models/album"
require "robbie/models/track"
require "robbie/models/genre"
require "robbie/autocomplete"

module Robbie
  @@cache_enabled = false

  class << self
    def setup(params)
      const_set(:API_KEY, params[:api_key])
      const_set(:API_SECRET, params[:api_secret])
    end

    def enable_cache
      @@cache_enabled = true
    end

    def disable_cache
      @@cache_enabled = false
    end

    def cache_enabled?
      @@cache_enabled
    end
  end
end
