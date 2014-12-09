require 'spider/version'
require 'spider/actions'
require 'spider/frame'
require 'mongoid'

module Spider
  class Core
    include Spider::Actions
    def initialize
      @links = Array.new
    end
  end
end
