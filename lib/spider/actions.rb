require 'spider/util'
require 'spider/model'
require 'term/ansicolor'
require 'redis'
require 'json'

module Spider
  module Actions
    include Util
    include Term::ANSIColor
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
          log "Scrapping #{l}"
          seed(l)
          scrape
        rescue Exception => e
          # Welcome
          print red, bold, "broken link", reset, "\n"
          print red, bold, e, reset, "\n"
          @links.delete_at i
        end
        depth -= 1
      end

      # cleaning the invalid links
      @links.compact
      begin

        # try to save to the database
        @links.map { |l|
          Link.create(location:l)
        }


      rescue Exception => e
        print red, bold, "Error saving to database", reset, "\n"
        print red, bold, e, reset, "\n"
      end

      self
    end

    def scrape
      # don't run if @body is empty
      return nil if @body.nil? or @body.empty?

      ## running a series of functions to filter
      ## the HTML pages for links
      @body
        .split('href')
        .map(&method(:when_valid_url   )).compact
        .map(&method(:append_to_links  )).compact
        .map(&method(:clean_link_hash  )).compact
        .map(&method(:corrent_encoding )).compact
        .map(&method(:make_db_safe     )).compact
        .uniq

      # puts @links
      print bold, blue, "#{@links.count} links", reset, "\n"
      self
    end

    def seed(location)
      @body = fetch_page(location).body
      self
    end
  end
end
