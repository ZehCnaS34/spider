require "spider/version"
require 'spider/util'
require 'spider/actions'


module Spider
  class Core
    include ::Spider::Util
    include ::Spider::Actions
    def initialize
      @links = Array.new
      @db    = Redis.new(port: 6379)
    end
  end
end
