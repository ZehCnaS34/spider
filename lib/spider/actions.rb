module Spider
  module Actions
    def crawl(depth=10)
      @links.each do |l|
        break if depth == 0
        seed(l)
        at -= 1
      end
    end
    def scrape
      if @body.nil?
        puts "body is nil"
        return nil
      end
      @links.concat @body.split(/href=['"]/)
      puts @links
      # return self for method chaining
      self
    end
    def seed(location)
      @body = fetch_page(location)
    end
  end
end
