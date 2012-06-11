require_relative '../../test_helper'
 
describe Simplicity do
  
  it "should not escape HTML marked safe" do
    unsafe = "<script>hack();</script>"
    escaped = "&lt;script&gt;hack();&lt;/script&gt;"
    safe = control = "<p>Announcement</p>".html_safe
    assert_equal unsafe.escape_html_unless_safe, escaped
    assert_equal safe.escape_html_unless_safe, control
  end
  
  it "should wrap text at 80 characters" do
    str = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque hendrerit dui id metus rhoncus sed."
    assert_equal str.wrap_text_at(80).split(/[\n]/)[0].size, 78
  end
  
  it "should parse dimension strings into an array" do
    arr = "300x200".to_dimensions
    assert_instance_of Array, arr
    assert_equal arr[0], 300
    assert_equal arr[1], 200
  end
  
  it "should parse dimension strings with ranges into arrays" do
    arr = "300-400x200".to_dimensions
    assert_instance_of Array, arr
    assert_equal arr[0][0], 300
    assert_equal arr[0][1], 400
    assert_equal arr[1], 200
  end
  
  it "should convert utf-8 in slugs" do
    assert_equal "\u00A9 2012".slugize, "copyright-2012"
  end
  
  it "should convert to lowercase in slugs" do
    assert_equal "Hello World".slugize, "hello-world"
  end
  
  it "should remove surrounding whitespace in slugs" do
    assert_equal " Nice, eh?".slugize, "nice-eh"
  end
  
  it "should replace non-word characters in slugs" do
    assert_equal "beep^boop".slugize, "beep-boop"
    assert_equal "wha_'_z up?".slugize, "wha-z-up"
  end
  
  it "should be blank when containing only whitespace" do
    assert "  ".blank?
    refute "hi".blank?
  end
  
  it "should respond to any? as a character array" do
    assert "pow".any?
    refute "".any?
  end
  
  it "should detect numeric values" do
    refute "twenty3".is_numeric?
    assert "23.0".is_numeric?
  end
 
end