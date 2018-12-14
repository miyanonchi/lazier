# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lazier/version'

Gem::Specification.new do |spec|
  spec.name          = "lazier"
  spec.version       = Lazier::VERSION
  spec.authors       = ["takumi.miyano01"]
  spec.email         = ["takumi.miyano01@g.softbank.co.jp"]
  spec.summary       = %q{Automate your tasks.}
  spec.description   = %q{Lazier makes your tasks easy to do.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
