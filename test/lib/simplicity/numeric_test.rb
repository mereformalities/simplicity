require_relative '../../test_helper'
 
describe Simplicity do
  
  it "should append ordinals for integers" do
    assert_equal 12.ordinal, "12th"
    assert_equal 112.ordinal, "112th"
    assert_equal 1031.ordinal, "1031st"
  end
  
  it "should bound between a given range" do
    assert_equal -23.bound(90, 120), 90
    assert_equal 123.bound(90, 120), 120
  end
  
end