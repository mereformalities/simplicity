module Simplicity
  module Helpers
    # Borrowed from MobileFu. These are various strings that can be found in mobile devices. 
    # Please feel free to add on to this list.
    MOBILE_USER_AGENTS =  'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' +
                          'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|' +
                          'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|' +
                          'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|' +
                          'webos|amoi|novarra|cdm|alcatel|pocket|ipad|iphone|mobileexplorer|' +
                          'mobile'
    
    # Returns either true or false depending on whether or not the user agent of
    # the device making the request is matched to a device in our regex.
    def is_mobile_device?
      request.user_agent.to_s.downcase =~ Regexp.new(Simplicity::Helpers::MOBILE_USER_AGENTS)
    end

    # Can check for a specific user agent
    # e.g., is_device?('iphone') or is_device?('mobileexplorer')
    def is_device?(type)
      request.user_agent.to_s.downcase.include?(type.to_s.downcase)
    end
    
    # Checks if controller is in the given list
    def controller_in?(arr)
      arr.include?(controller_name)
    end
    
    # Checks if action is in the given list
    def action_in?(arr)
      arr.include?(action_name)
    end
    
    def index_action?
      action_name == "index"
    end
    
    def show_action?
      action_name == "show"
    end
    
    # Provide an interface to convert a block into a partial.
    #  1. Capture is a Rails helper which will 'capture' the output of a block into a variable
    #  2. Merge the 'body' variable into our options hash
    #  3. Render the partial with given options hash (just like calling the partial directly)
    # 
    def block_to_partial(partial_name, options = {}, &block)
      options.merge!(:body => capture(&block))
      concat(render(:partial => partial_name, :locals => options), block.binding)
    end

    # Join new classes with existing options
    def join_classes(options, arr)
      arr = [arr] if arr.is_a?(String)
      options_str = options[:class] || ""
      classes = options_str.split(" ") || []
      classes.concat(arr)
      classes.compact.join(" ")
    end
    
  end
end