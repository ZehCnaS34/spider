require "spider/version"
require 'net/http'

module Spider
  attr_reader :links
  # Your code goes here...

  def get_response(uri)
    if uri =~ /http:\/\//
      response = Net::HTTP.get_response(URI.parse(uri))
    else
      response = Net::HTTP.get_response(URI.parse("http://#{uri}"))
    end

  end

  def initialize
    @links = Array.new
  end

  def crawl(depth=10)
    at = 0
    @links.each do |l|
      if at == depth
        break
      end
      seed(l)
      at += 1
    end
    puts @links
  end

  def seed(uri)
    response = get_response(uri)


    ## start parsing the reponse body
    response.body.split("\n").each do |e|
      ## if href is matched
      if e =~ /href=/
        meta_link = /href=['"].+['"]/.match(e).to_s
        # remove the href from the meta_link
        meta_link = meta_link[6..meta_link.length]

        # define where the href locations stops
        stopper = meta_link.to_s.index(/['"]/)
        if meta_link.to_s.length > 1
          # almost in final form
          meta_link = meta_link.to_s[0..stopper-1]

          ## if link starts with http
          if meta_link =~ /http:\/\//

            meta_link = meta_link[7..meta_link.length]
            loc_index = meta_link.index("/")
            # puts meta_link
            # puts loc_index


            if loc_index
              @links << meta_link[0..loc_index-1] if @links.index(meta_link[0..loc_index-1]).nil?
            else
              @links << meta_link if @links.index(meta_link).nil?
            end

          end


        end
      end
    end

    # @links = @links.map { |l| l if l =~ /http:\/\// }.compact.uni
    @links = @links.compact.uniq
    puts @links.count
    self
  end
end
