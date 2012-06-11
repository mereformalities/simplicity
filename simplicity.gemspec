# -*- encoding: utf-8 -*-
require File.expand_path('../lib/simplicity/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'simplicity'
  gem.version       = Simplicity::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ["Brant Watrous"]
  gem.email         = ["watroubd@gmail.com"]
  gem.homepage      = ''
  gem.summary       = 'Simplicity gives you tools to write more concise ActionController and helper methods'
  gem.description   = 'Code-simplifying additions to Rails'

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]
  
  gem.add_dependency('actionpack', '>= 3.0.9')
  gem.add_dependency('activerecord', '>= 3.0.9')
end
