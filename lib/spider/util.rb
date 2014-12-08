require 'net/http'
require 'spider/log'
require 'json'

module Spider
  module Util
    include ::Spider::Log
    def is_external_link(e)
      res = /http::\/\//.match e
      return res.string if res
      nil
    end

    # append to obj var @links if not already included
    ## l is a nokogiri css object
    def append_to_links(l)
      if not @links.include? l
        @links << l
        log_success "Adding: #{l}"
      else
        log_info "Rejecting: #{l}::already in @links list"
      end
    end
  end

end
