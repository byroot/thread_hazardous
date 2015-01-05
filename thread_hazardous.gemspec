# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thread_hazardous/version'

Gem::Specification.new do |spec|
  spec.name          = 'thread_hazardous'
  spec.version       = ThreadHazardous::VERSION
  spec.authors       = ['Jean Boussier']
  spec.email         = ['jean.boussier@gmail.com']
  spec.summary       = %q{Monkey patch thread_safe to make it faster in non thread safe applications}
  spec.description   = %q{CAUTION: Use this gem at your own risk.}
  spec.homepage      = 'https://github.com/byroot/thread_hazardous'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thread_safe', '~> 0.3.4'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '>= 4'
end
