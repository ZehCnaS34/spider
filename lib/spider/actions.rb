require 'spider/util'
require 'term/ansicolor'

module Spider
  module Actions
    include ::Spider::Util
    include Term::ANSIColor

    def crawl(depth=10)

      if @links.empty?
        puts "There are not links alread present in the application, please seed the application"
      end

      @links.each do |l|
        break if depth == 0
        puts "trying to fetch #{l}"


        ## just in case the scraped pages links are not properly formed
        ## print link is broken in the ling
        begin
          seed(l)
          scrape
        rescue
          # Welcome
          print red, bold, "broken link", reset, "\n"
        end
        depth -= 1
      end
    end

    def scrape
      return nil if @body.nil?
      @body
        .split('href')
        .map(&method(:when_valid_url)).compact
        .map(&method(:append_to_links)).compact
        .uniq


      puts @links
      print bold, blue, "#{@links.count} links", reset, "\n"

      self
    end

    def seed(location)
      @body = fetch_page(location).body
      self
    end
  end
end
