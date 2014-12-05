require "spider/version"
require 'net/http'

module Spider
  attr_reader :links
  # Your code goes here...
  def initialize
    @links = Array.new
  end


  def seed(uri)
    response = Net::HTTP.get_response(URI.parse(uri))

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
          @links << meta_link.to_s[0..stopper-1]
        end
      end
    end

    @links = @links.map { |l| l if l =~ /http:\/\// }.compact

    puts @links
  end
end
