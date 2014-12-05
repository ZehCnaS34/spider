require "spider/version"
require 'net/http'

module Spider
  # Your code goes here...

  def look
    uri = "http://stackoverflow.com/questions/1878891/how-to-load-a-web-page-and-search-for-a-word-in-ruby"
    response = Net::HTTP.get_response(URI.parse(uri))
    @links = Array.new


    ## start parsing the reponse body
    response.body.split("\n").each do |e|


      ## if href is matched
      if e =~ /href=/
        meta_link = /href=['"].+['"]/.match(e).to_s
        meta_link = meta_link[6..meta_link.length]
        puts "new meta"
        puts meta_link
        stopper = meta_link.to_s.index(/['"]/)
        if meta_link.to_s.length > 1
          @links << meta_link.to_s[0..stopper]
        end

      end
    end

    puts @links
  end
end
