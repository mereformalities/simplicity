require_relative '../../test_helper'
 
describe Simplicity::Navigation do
  
  subject { ActionController::Base.new }
  
  before { subject.class.set_meta_defaults({:title => 'Custom Title', 
                                            :description => 'Custom Description',
                                            :body_class => 'custom'}) }
 
  it "should allow the configuration of static defaults" do
    assert_equal subject.send(:meta_title), 'Custom Title'
    assert_equal subject.send(:meta_description), 'Custom Description'
    assert_equal subject.send(:body_class), 'custom'
  end
 
end