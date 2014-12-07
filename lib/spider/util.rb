require 'net/http'
require 'json'

module Spider
  module Util

    def log(content="", color, &block)
      content = block.call if block_given?
      print bold, Term::ANSIColor.send(color) , "Log[#{content}]", reset, "\n"
    end

    def log_error(content)
      log "Error:#{content}", :red
    end

    def log_info(content)
      log "Info:#{content}", :cyan
    end

    def log_success(content)
      log "Success:#{content}", :green
    end


    def is_external_link(e)
      res = /http::\/\//.match e
      return res.string if res
      nil
    end

    # append to obj var @links if not already included
    ## l is a nokogiri css object
    def append_to_links(l)
      print bold, green, "Adding: #{l}", reset, "\n"
      @links << l if not @links.include? l
    end
  end
end
