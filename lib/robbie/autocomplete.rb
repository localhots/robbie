module Robbie
  class Autocomplete
    class << self
      def complete(q)
        Parsers::Search.autocomplete(q)
      end

      def predict(q)
        Parsers::Search.single_stage_search(q)
      end
    end
  end
end
