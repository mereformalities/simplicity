require_relative '../../test_helper'
 
describe Simplicity do
 
  it "must allow nil.any?" do
    instance = nil
    instance.any?.wont_be_nil
  end
  
  it "must return length of zero" do
    instance = nil
    assert_equal instance.length, 0
  end
  
  it "must answer true for empty?" do
    instance = nil
    assert instance.empty?
  end
 
end