require_relative '../../test_helper'
 
describe Simplicity::Navigation do
  
  subject { ActionController::Base.new }
  
  before { subject.class.meta_defaults({:title => 'Default Title', 
                                        :description => 'Default Description',
                                        :body_class => 'custom'}) }
 
  it "should allow the configuration of static defaults" do
    assert_equal subject.send(:meta_title), 'Default Title'
    assert_equal subject.send(:meta_description), 'Default Description'
    assert_equal subject.send(:body_class), 'custom'
  end
  
  it "should allow writing a meta_title to read when rendering" do
    subject.meta_title = 'Page Title'
    assert_equal subject.meta_title, 'Page Title'
    subject.view_context.meta_title = 'Page Title from View'
    assert_equal subject.view_context.meta_title, 'Page Title from View'
  end
  
  it "should allow writing a meta_description to read when rendering" do
    subject.meta_description = 'Page Description'
    assert_equal subject.meta_description, 'Page Description'
    subject.view_context.meta_description = 'Page Description from View'
    assert_equal subject.view_context.meta_description, 'Page Description from View'
  end
 
end