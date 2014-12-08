require 'mongoid'

module Spider
  module Models
    class Link
      include Mongoid::Document
      field :location
      field :text
      store_in collection: 'links', database: 'spider', session: 'default'
    end

    class Page
      include Mongoid::Document
      field :title
      embeds_many :links
      store_in collection: 'pages', database: 'spider', session: 'default'
    end
  end
end
