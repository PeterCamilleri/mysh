# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mysh/version'

Gem::Specification.new do |spec|
  spec.name          = "mysh"
  spec.version       = Mysh::VERSION
  spec.authors       = ["Peter Camilleri"]
  spec.email         = ["peter.c.camilleri@gmail.com"]

  spec.summary       = Mysh::DESCRIPTION
  spec.description   = "mysh -- a Ruby inspired command shell " +
                       "for CLI and application use."
  spec.homepage      = "https://github.com/PeterCamilleri/mysh"

  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "bundler", ">= 2.1.0"
  spec.add_development_dependency 'minitest', "~> 5.7"
  spec.add_development_dependency 'rdoc', "~> 5.0"
  spec.add_development_dependency 'reek', "~> 5.0.2"

  spec.add_runtime_dependency     'mini_readline', "~> 0.9.1"
  spec.add_runtime_dependency     'mini_term', "~> 0.1.0"
  spec.add_runtime_dependency     'pause_output', "~> 0.2.0"
  spec.add_runtime_dependency     'format_output', "~> 0.1.0"
  spec.add_runtime_dependency     'vls', "~> 0.4.1"
  spec.add_runtime_dependency     'in_array', ">= 1.0"
  spec.add_runtime_dependency     'insouciant', "~> 0.1.0"
end
