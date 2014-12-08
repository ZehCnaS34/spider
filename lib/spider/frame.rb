module Spider
  class Frame
    attr_accessor :title, :body, :past_location

    def initialize
      yield self
    end


  end
end
