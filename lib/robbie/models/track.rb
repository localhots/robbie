module Robbie
  class Track < BaseModel
    attr_accessor :id, :disc_id, :position, :artists, :title, :duration
  end
end
