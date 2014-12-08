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
      log_info "At link scrape depth #{depth}"
      if @links.empty? and @body.nil?
        log_error "No links pre-cached"
      end

      begin
        # try to save to the database
        @links.each do |l|
          existing_link = Link.where(location: l)
          if existing_link.nil?
            log_info "Adding #{l} to database"
            Link.create(location:l)
          else
            log_warning "#{l} already exists"
          end
        end

        # # creating the page with the relationship
        # existing_page = Page.where(title: @page_title)
        # if existing_page.nil?
          Page.create(title: @page_title, links: Link.each.to_a)
        # else
        #   log_warning "#{@page_title} already in db"
        # end


      # doing some cool ass things
      rescue Exception => e
        log_error "Error saving to the database"
        log_error e
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

      self
    end

    def scrape(body=@body)
      log_info "Begin Scrape for #{@page_title}"
       body
        .map(&method(:is_external_link)).compact.uniq
        .map(&method(:append_to_links))
      self
    end

    ## adds a starting location, then scrapes
    def seed(location)
      page = fetch_page(location)
      @page_title = page.title
      @body = page.css('a')
        .map { |l| l['href'] }.uniq
      scrape
      self
    end

    # def cached
    #   page = fetch_page(Link.each.last)
    #   @page_title = page.title
    #   @
    # end


    # ## return an enumerator of all saved links
    # def all
    #   Link.each
    # end
  end
end
