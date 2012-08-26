# encoding: UTF-8
require File.expand_path('../lib/robbie/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Gregory Eremin"]
  gem.email         = %w[ magnolia_fan@me.com ]
  gem.description   = %q{ Rovi API wrapper }
  gem.summary       = %q{ Rovi API wrapper }
  gem.homepage      = "https://github.com/magnolia-fan/robbie"

  gem.files         = %x{ git ls-files }.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |file| File.basename(file) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "robbie"
  gem.require_paths = %w[ lib ]
  gem.version       = Robbie::VERSION
  gem.platform      = Gem::Platform::RUBY

  gem.add_dependency "httparty"
  gem.add_dependency "oj"
end
