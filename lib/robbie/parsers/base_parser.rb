module Robbie
  module Parsers
    class BaseParser
      include HTTParty
      base_uri "api.rovicorp.com"
      format :json
      @@calls = []

      class << self
        def sig
          Digest::MD5.hexdigest("#{API_KEY}#{API_SECRET}#{Time.now.to_i}")
        end

        def query(path, params)
          unless Robbie.const_defined?(:API_KEY) and Robbie.const_defined?(:API_SECRET)
            raise Exception.new("No API credentials given")
          end

          params_str = params
            .merge({ apikey: API_KEY, sig: sig, format: "json" })
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

        def load(uri)
          if Robbie.free_limits?
            @@calls = @@calls.length > 5 ? @@calls.slice(-5, 5) : @@calls
            if @@calls.length > 5 && Time.now.to_f - @@calls.first <= 1.0
              sleep(1.05 - (Time.now.to_f - @@calls.first))
            end
            @@calls << Time.now.to_f
          end

          get(uri)
        end
      end
    end
  end
end
