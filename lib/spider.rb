require 'spider/version'
require 'spider/actions'

module Spider
  class Core
    include ::Spider::Actions
    def initialize
      @links = Array.new
    end
  end
end
