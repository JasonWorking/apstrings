# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'apstrings/version'

Gem::Specification.new do |spec|
  spec.name          = "apstrings"
  spec.version       = Apstrings::VERSION
  spec.authors       = ["JasonWorking"]
  spec.email         = ["331314708@qq.com"]

  spec.summary       = %q{Apple dot strings file parser.}
  spec.description   = %q{An easy to use Apple dot strings file parser with encoding handled.}
  spec.homepage      = "https://github.com/JasonWorking"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "colorize"
  spec.add_development_dependency "json"

  
end
