require 'spider/util'

module Spider
  module Actions
    include ::Spider::Util
    def crawl(depth=10)
      @links.each do |l|
        break if depth == 0
        seed(l)
        at -= 1
      end
    end
    def scrape
      return nil if @body.nil?
      # @links.concat

      puts @body
        .split('=')
        .map(&method(:when_valid_url)).compact
        .map(&method(:has_dot_com)).compact
        .map(&method(:when_valid_url)).compact
        .uniq

      self
    end
    def seed(location)
      @body = fetch_page(location).body
      self
    end
  end
end
