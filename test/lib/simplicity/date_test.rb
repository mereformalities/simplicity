require_relative '../../test_helper'
 
describe Simplicity do
  
  it "should return a timestamp" do
    d = Date.new(2012, 1, 10)
    assert_equal d.timestamp, d.to_time.to_i
  end
  
  it "should find the first day of the month" do
    tenth = Date.new(2012, 1, 10)
    first = Date.new(2012, 1, 1)
    assert_equal tenth.first_day_of_month.timestamp, first.timestamp 
  end
  
  it "should find the last day of the month" do
    tenth = Date.new(2012, 1, 10)
    last  = Date.new(2012, 1, 31)
    assert_equal tenth.last_day_of_month.timestamp, last.timestamp 
  end
  
  it "should find the middle of the month" do
    tenth  = Date.new(2012, 1, 10)
    middle = Date.new(2012, 1, 16)
    assert_equal tenth.middle_of_month.timestamp, middle.timestamp 
  end
  
end