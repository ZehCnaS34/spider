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

    # welcome
    def crawl(depth=10)
      if @links.empty?
        puts "There are not links alread present in the application, please seed the application"
      end

      ## looping throught existing links
      @links.each_with_index do |l, i|
        break if depth == 0
        ## print link is broken in the ling
        begin
          log "Scrapping #{l}", :blue
          seed(l)
          scrape
        rescue Exception => e
          # Welcome
          log "broken link", :red
          log e, :red
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

    def scrape
      # don't run if @body is empty
      # return nil if @body.nil? or @body.empty? #

      @body.css('a')
        .map(&method(:is_external_link)).compact.uniq
        .map(&method(:append_to_links))

      # puts @links
      log_info "#{@links.count} links"
      self
    end

    def seed(location)
      @body = Nokogiri::HTML(RestClient.get(location)).css('a')
      # return self
      self
    end

    ## return an enumerator of all saved links
    def all
      Link.each
    end
  end
end
