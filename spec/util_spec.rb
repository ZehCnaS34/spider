require 'spider'
require 'spider/util'
# require 'net/http'


class TestUtil
  include Spider::Util
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
end
