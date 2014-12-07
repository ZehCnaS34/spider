require 'spider'
require 'spider/util'
# require 'net/http'


class TestUtil
  include Spider::Util
  attr_reader :links
  def initialize
    @links = Array.new
  end
end


RSpec.describe Spider::Util do
  before(:each){ @mock = TestUtil.new }

  describe "#is_external_link" do
    it "should return a string when is a valid url" do
      expect(@mock.is_external_link("http:://google.com")).to eq("http:://google.com")
      expect(@mock.is_external_link("not a real url")).to be_nil
    end
  end

  describe "#append_to_links" do
    before :all do
      @mock.links = ["http://google.com", "http://awesome.com"]
      @new_links = ['http://google.com', 'http://that-new-new.com']
    end

    it "should append to @links only if links does not already contain it" do
      @new_links.each(&@mock.append_to_links)
    end
  end

end
