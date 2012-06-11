require_relative '../../test_helper'
 
describe Simplicity::Helpers do
  
  subject { ActionController::Base.new }
  
  before { subject.request = ActionController::TestRequest.new() }
 
  it "should join classes" do
    options = {:class => 'great'}
    str = subject.join_classes(options, ['sweet', 'neat'])
    assert_equal str, "great sweet neat"
  end
  
  it "should know if request came from mobile device" do    
    subject.request.user_agent = 'iphone'
    assert subject.is_mobile_device?
    assert subject.is_device?('iPhone')
  end
  
  it "should know if request was not mobile" do
    subject.request.user_agent = 'Safari'
    refute subject.is_mobile_device?
    refute subject.is_device?('iPhone')
  end
 
end