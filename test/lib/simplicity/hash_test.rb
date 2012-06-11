require_relative '../../test_helper'
 
describe Simplicity do
  
  it "should produce a valid query string" do
    h = { :param1 => :dense, :param2 => 200 }
    assert_equal h.to_query_string, "?param1=dense&param2=200"
  end
  
end