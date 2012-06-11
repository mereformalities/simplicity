require 'active_support'
require 'action_controller'
require 'active_record'

# http://stackoverflow.com/questions/2900370/why-does-ruby-
# 1-9-2-remove-from-load-path-and-whats-the-alternative
require_relative 'simplicity/version'
require_relative 'simplicity/core_ext/object'
require_relative 'simplicity/core_ext/string'
require_relative 'simplicity/core_ext/symbol'
require_relative 'simplicity/core_ext/date'
require_relative 'simplicity/core_ext/array'
require_relative 'simplicity/core_ext/hash'
require_relative 'simplicity/core_ext/numeric'
require_relative 'simplicity/core_ext/nil_class'
require_relative 'simplicity/helpers'
require_relative 'simplicity/model_helpers'
require_relative 'simplicity/navigation'
require_relative 'simplicity/debugging'

module Simplicity
  # Your code goes here...
end

ActionView::Base.send :include, Simplicity::Helpers
ActionController::Base.send :include, Simplicity::Helpers
ActionController::Base.send :include, Simplicity::Navigation
ActionController::Base.send :include, Simplicity::Debugging
ActionController::Base.send :extend, Simplicity::Debugging
ActiveRecord::Base.send :include, Simplicity::ModelHelpers
ActiveRecord::Base.send :include, Simplicity::Debugging
ActiveRecord::Base.send :extend, Simplicity::Debugging