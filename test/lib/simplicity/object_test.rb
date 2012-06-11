require_relative '../../test_helper'
 
describe Simplicity do
  
  it "should return false for blank? unless nil" do
    obj = Object.new
    refute obj.blank?
  end
  
end