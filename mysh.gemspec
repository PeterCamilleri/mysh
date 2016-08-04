# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mysh/version'

Gem::Specification.new do |spec|
  spec.name          = "mysh"
  spec.version       = Mysh::VERSION
  spec.authors       = ["Peter Camilleri"]
  spec.email         = ["peter.c.camilleri@gmail.com"]

  spec.summary       = Mysh::SUMMARY
  spec.description   = "mysh -- a Ruby inspired command shell " +
                       "for CLI and application use."
  spec.homepage      = "http://teuthida-technologies.com/"

  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>=1.9.3'

  spec.add_development_dependency "bundler",          "~> 1.3"
  spec.add_development_dependency "rake",             "~> 10.0"
  spec.add_development_dependency 'reek',             "~> 3.0"
  spec.add_development_dependency 'minitest',         "~> 5.7"
  spec.add_development_dependency 'minitest_visible', ">= 0.1.1"
  spec.add_development_dependency 'rdoc',             "~> 4.0.1"

  spec.add_runtime_dependency     'mini_readline',    ">= 0.6.0"
end
