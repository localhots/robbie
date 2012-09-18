module Robbie
  module Parsers
    class BaseParser
      include HTTParty
      base_uri "api.rovicorp.com"
      format :json
      @@meta_calls = []
      @@autocomplete_calls = []

      class << self

        def sig(type = :meta)
          case type
          when :meta
            Digest::MD5.hexdigest("#{META_API_KEY}#{META_API_SECRET}#{Time.now.to_i}")
          when :autocomplete
            Digest::MD5.hexdigest("#{AUTOCOMPLETE_API_KEY}#{AUTOCOMPLETE_API_SECRET}#{Time.now.to_i}")
          end
        end

        def query(path, params)
          type = (path.match(/^\/search\/v2\/music\/autocomplete/) ? :autocomplete : :meta)

          if type == :meta
            unless Robbie.const_defined?(:META_API_KEY) and Robbie.const_defined?(:META_API_SECRET)
              raise Exception.new("No meta API credentials given")
            end
          elsif type == :autocomplete
            unless Robbie.const_defined?(:AUTOCOMPLETE_API_KEY) and Robbie.const_defined?(:AUTOCOMPLETE_API_SECRET)
              raise Exception.new("No autocomplete API credentials given")
            end
          end

          params_str = params
            .merge({ apikey: (type == :meta ? META_API_KEY : AUTOCOMPLETE_API_KEY), sig: sig(type), format: "json" })
            .map{ |key, val| "#{key}=#{val}" }.join("&")

          if Robbie.cache_enabled?
            cache_key = "#{path}?#{params.inspect}".scan(/\w/).join
            cache_file = File.expand_path("../../../../tmp/cache/#{cache_key}", __FILE__)
            if File.exist?(cache_file)
              MultiJson.load(File.open(cache_file).read)
            else
              data = load("#{path}?#{params_str}")
              File.open(cache_file, "w") do |file|
                file.write(MultiJson.dump(data)) unless data.nil? or data.empty?
              end
              data
            end
          else
            load("#{path}?#{params_str}")
          end
        end

        def load(type = :meta, uri)
          if type == :meta
            calls = @@meta_calls
            limit = 5
          elsif type == :autocomplete
            calls = @@autocomplete_calls
            limit = 10
          end

          if Robbie.free_limits?
            calls = calls.length > limit ? calls.slice(-limit, limit) : calls
            if calls.length > limit && Time.now.to_f - calls.first <= 1.0
              sleep(1.05 - (Time.now.to_f - calls.first))
            end
            calls << Time.now.to_f
          end

          get(uri)
        end
      end
    end
  end
end
