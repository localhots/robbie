module Robbie
  class BaseModel
    def initialize(values)
      values.each{ |key, val| send(:"#{key}=", val) }
    end
  end
end
