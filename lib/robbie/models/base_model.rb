module Robbie
  class BaseModel
    def initialize(values)
      values.each do |key, val|
        send(:"#{key}=", val)
      end
    end
  end
end
