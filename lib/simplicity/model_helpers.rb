module Simplicity
  module ModelHelpers
    
    # Send orm errors to the console
    def log_errors
      console "#{model.class.to_s.titleize} has the following errors:" if errors.any?
      errors.full_messages.each do |message|
        console "* #{message}"
      end
    end
    
  end
end

# Use titleize not humanize 
# for form attribute labels
module ActiveModel
  module Translation
    def human_attribute_name_with_foo attribute, options = {}
      human_attribute_name_without_foo attribute, options.merge( :default => attribute.to_s.titleize )
    end
    alias_method_chain :human_attribute_name, :foo
  end
end