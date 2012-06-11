require_relative '../../test_helper'
 
describe Simplicity do
  
  it "should use hyphens in slugs" do
    assert_equal :kittehs_eat_slugs.to_slug, "kittehs-eat-slugs"
  end
  
end