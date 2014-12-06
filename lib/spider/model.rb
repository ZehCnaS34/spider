require 'mongoid'

module Spider
  module Models
    class Link
      include Mongoid::Document
      field :location
      store_in collection: 'links', database: 'other', session: 'secondary'
    end
  end
end
