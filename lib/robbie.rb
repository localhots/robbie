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
      const_set(:META_API_KEY, params[:meta_api_key])
      const_set(:META_API_SECRET, params[:meta_api_secret])
      const_set(:AUTOCOMPLETE_API_KEY, params[:autocomplete_api_key])
      const_set(:AUTOCOMPLETE_API_SECRET, params[:autocomplete_api_secret])
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

    def free_limits?
      true
    end
  end
end
