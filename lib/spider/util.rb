require 'net/http'
require 'json'

module Spider
  module Util

    def log(content="", &block)
      content = block.call if block_given?
      print bold, cyan, "-----Debug:[#{content}]-----", reset, "\n"
    end

    def is_external_link(e)
      res = /http::\/\//.match e


      return res.string if res
      nil
    end

    # append to obj var @links if not already included
    ## l is a nokogiri css object
    def append_to_links(l)
      print bold, green, "Adding: #{l['href']}", reset, "\n"
      @links << l['href'] if not @links.include? l['href']
    end

    def clean_link_hash(l)
      # res = /#/.match l
      # return res.to_s.split('#')[0] if res
      # nil

      l.split '#' if l =~ /#/
    end

    def get_response(uri)
      if uri =~ /http:\/\//
        Net::HTTP.get_response(URI.parse(uri))
      else
        Net::HTTP.get_response(URI.parse("http://#{uri}"))
      end
    end

    def fetch_page(uri)
      @body = get_response(uri)
    end

    def make_db_safe(l)
      l.encode("iso-8859-1").force_encoding("utf-8")
    end

    def corrent_encoding(e)
      Base64.decode64(e)
    end

  end
end
