require "helper"

class TestNoAttributes < MiniTest::Unit::TestCase
  def setup
    @agent = Mechanize.new
  end

  def test_parse_no_attributes
    @agent.get('http://localhost/tc_no_attributes.html')

    # HACK no assertions
  end
end
