module Simplicity
  module Navigation
  
    # class Error < RuntimeError; end
    # class PermissionDenied < Error; end

    def self.included(base)
      # Accessors
      base.send :attr_writer, :page_uid
      base.send :attr_writer, :meta_title
      base.send :attr_writer, :meta_description
      base.send :attr_accessor, :meta_keywords
      # Module methods
      base.send :include, InstanceMethods
      base.send :extend, ClassMethods
      # Class instance variables
      base.send :class_attribute, :body_class_rules
      base.send :class_attribute, :body_class_default, :instance_writer => false
      base.send :class_attribute, :meta_title_default, :instance_writer => false
      base.send :class_attribute, :meta_description_default, :instance_writer => false
      # Helper attributes
      base.send :helper_attr, :page_uid
      base.send :helper_attr, :meta_title
      base.send :helper_attr, :meta_description
      base.send :helper_attr, :meta_keywords
      # Helper methods
      base.send :helper_method, :nav_class
      base.send :helper_method, :body_class
      base.send :helper_method, :subnav_class
      # Shortcuts
      base.class_eval do        
        def self.body_class(name, options = {})
          self.add_body_class_rule(:body, name, options)
        end 
      
        def self.nav_class(name, options = {})
          self.add_body_class_rule(:nav, name, options)
        end
      
        def self.subnav_class(name, options = {})
          self.add_body_class_rule(:subnav, name, options)
        end
      end
    end
  
  
    module ClassMethods
      # Higher priority statements should be written last
      #
      # Valid options
      #   :only, :for - Only give the class for the given actions
      #   :except, :for_all_except - Set class for everything but 
      #
      def add_body_class_rule(type, name, options = {})
        options.assert_valid_keys( :only, :for, :for_all_except, :except ) 
        options[:only] ||= options[:for] if options[:for]
        options[:except] ||= options[:for_all_except] if options[:for_all_except]
    
        # convert any actions into symbols
        for key in [:only, :except]
          if options.has_key?(key)
            options[key] = [options[key]] unless Array === options[key]
            options[key] = options[key].compact.collect{|v| v.to_sym}
          end 
        end      
      
        self.body_class_rules ||= []
        self.body_class_rules << { :type => type, :name => name, :options => options }
      
        # Run before filter whenever body_class
        # is used, but only declare filter once
        unless (@body_class_filter_declared ||= false)
          @body_class_filter_declared = true
          before_filter :resolve_body_class
        end
      end
      
      # Pass in custom defaults
      def meta_defaults(defaults = {})
        self.meta_title_default = defaults[:title]
        self.meta_description_default = defaults[:description]
        self.body_class_default = defaults[:body_class] || 'default'
      end
    end
  
  
    module InstanceMethods
    
      # unique per action page_id
      def page_uid
        @page_id || params[:controller] + '_' + params[:action]
      end
      
      # http://guides.rubyonrails.org/active_support_core_extensions.html
      # Consider: attr_accessor_with_default :primary_key, 'id'
      def meta_title
        @meta_title || self.meta_title_default
      end

      def meta_description
        @meta_description || self.meta_description_default
      end

      def body_class
        @body_class || self.body_class_default
      end  

      def nav_class
        @nav_class || self.body_class_default
      end   

      def subnav_class
        @subnav_class || self.body_class_default
      end
    
      protected
    
      def resolve_body_class
        self.body_class_rules.each do |rule| 
          type    = rule[:type]
          name    = rule[:name] || self.body_class_default
          options = rule[:options]
        
          if options.has_key?(:only)
            cond = options[:only].include?( (params[:action] || 'index').to_sym ) 
            case type
              when :body    then @body_class = name if cond
              when :nav     then @nav_class = name if cond
              when :subnav  then @subnav_class = name if cond
            end
          end
      
          if options.has_key?(:except)
            cond = options[:except].include?( (params[:action] || 'index').to_sym ) 
            case type
              when :body    then @body_class = name unless cond
              when :nav     then @nav_class = name unless cond
              when :subnav  then @subnav_class = name unless cond
            end
          end
        
          # Without options, name is universally applied
          if options.nil? or options.empty? 
            case type
              when :body    then @body_class = name
              when :nav     then @nav_class = name
              when :subnav  then @subnav_class = name
            end
          end
        end
      end
    
      # make multiple layouts work intuitively
      def change_layout(name, options = {})
        if options.kind_of?(Hash) && options[:for].is_a?(Array)
          options[:for].include?(action_name.to_sym) ? name : 'application'
        else
          name
        end
      end
    
      # extend to redirect to various 'home' pages
      def redirect_to_index(msg = nil)
        flash[:notice] = msg if msg
        redirect_to(root_path) 
      end
        
    end
  end
end