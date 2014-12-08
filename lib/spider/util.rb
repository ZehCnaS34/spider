require 'net/http'
require 'spider/log'
require 'json'

module Spider
  module Util
    include ::Spider::Log


    # Returns nil or a String whether the given string
    # passes the regular expression test
    #
    # @param format [String]
    # @return [String|Nil]
    def is_external_link(e)
      log_error "#{e} has wrong link type::#{e.class}" if e.class != String
      res = /(^http|^\/\/)/.match e

      if res
        return res.string
      else
        log_error "#{e} not external link"
      end
      nil
    end

    # append to obj var @links if not already included
    ## l is a nokogiri css object
    def append_to_links(l)
      if not @links.include? l
        @links << l
        log_success "Adding: #{l}"
      else
        log_warning "Rejecting: #{l}::already in @links list"
      end
    end

    def fetch_page(location)
      Nokogiri::HTML(RestClient.get(location))
    end



  end

end
