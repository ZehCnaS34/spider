require 'spider/util'
require 'spider/model'
require 'json'
require 'nokogiri'
require 'restclient'

module Spider
  module Actions
    include Util
    include Log
    include Models

    # loops through the existing links
    # and scrapes to a given depth
    def crawl(depth=10)
      if @links.empty? and @body.nil?
        log_error "No links pre-cached"
      end

      ## looping throught existing links
      @links.each_with_index do |l, i|
        break if depth == 0
        ## print link is broken in the ling
        begin
          log_info "Scrapping #{l}"
          seed(l)
          scrape
        rescue Exception => e
          # Welcome
          log_error "broken link"
          log_error e
          @links.delete_at i
        end
        depth -= 1
      end

      # cleaning the invalid links
      @links.compact
      begin

        # try to save to the database
        @links.map { |l|
          log_info "Adding #{l} to database"
          Link.create(location:l)
        }

      # doing some cool ass things
      rescue Exception => e
        log_error "Error saving to the database"
        log_error e
      end

      self
    end

    def scrape(body=@body)
      olg_info "Begin Scrape"
       body
        .map(&method(:is_external_link)).compact.uniq
        .map(&method(:append_to_links))
      self
    end

    ## adds a starting location, then scrapes
    def seed(location)
      @body = fetch_page(location).css('a')
        .map { |l| l['href'] }
#        .map { |l| l if not l.nil? }.compact
      scrape
      # to run more commands
      self
    end

    ## return an enumerator of all saved links
    def all
      Link.each
    end
  end
end
