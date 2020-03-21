# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'irb_tracker/version'

Gem::Specification.new do |spec|
  spec.name          = 'irb_tracker'
  spec.version       = IRBTracker::VERSION
  spec.authors       = ['Al-waleed Shihadeh']
  spec.email         = ['wshihadeh dot dev at gmail dot com']

  spec.summary       = 'Track and corrolate IRB activities to users.'
  spec.description   = 'Track all commands exected in an IRB console and '\
                       'correlate the actions to the users executed them.'
  spec.homepage      = 'https://github.com/wshihadeh/irb_tracker'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['homepage_uri'] = spec.homepage

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'net-ldap', '~> 0.16.0'

  spec.add_development_dependency 'bundler', '~> 2.1.4'
  spec.add_development_dependency 'fluent-logger', '~> 0.8.1'
  spec.add_development_dependency 'net-ldap', '~> 0.16.0'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.75.1'
end
