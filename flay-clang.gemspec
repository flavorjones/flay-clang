# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flay/clang/version'

Gem::Specification.new do |spec|
  spec.name          = "flay-clang"
  spec.version       = Flay::Clang::VERSION
  spec.authors       = ["Mike Dalessio"]
  spec.email         = ["mike.dalessio@gmail.com"]

  spec.summary       = "Flay plugin for C and C++ code."
  spec.description   = "Analyze C and C++ code for structural similarities."
  spec.homepage      = "https://github.com/flavorjones/flay-clang"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency "flay", "~> 2.7.0"
#  spec.add_dependency "ffi-clang", "~> 0.1.0"

  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
