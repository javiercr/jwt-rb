# coding: utf-8
require File.expand_path('../lib/jwt/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = 'jwt-rb'
  spec.version       = JWT::VERSION
  spec.authors       = ["ChupipandiCrew"]
  spec.email         = ["chupi@chupipandi.com"]
  spec.summary       = %q{Ruby gem to encode/ decode JWT}
  spec.homepage      = "http://github.com/chupipandi/jwt-rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'timecop'

  spec.add_runtime_dependency 'hashie'
end
