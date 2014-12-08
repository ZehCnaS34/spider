require 'spider/version'
require 'spider/actions'
require 'mongoid'

module Spider
  class Core
    include Spider::Actions
    def initialize
      Mongoid.load!(File.expand_path(File.join(File.dirname(__FILE__), "mongoid.yml")), :production)
      @links = Array.new
    end
  end
end
