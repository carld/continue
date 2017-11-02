# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "continue/version"

Gem::Specification.new do |spec|
  spec.name          = "continue"
  spec.version       = Continue::VERSION
  spec.authors       = ["Carl Douglas"]
  spec.email         = ["105003+carld@users.noreply.github.com"]

  spec.summary       = %q{A simple command chain}
  spec.description   = %q{Run a series of commands, preventing execution of remaining commands on a error}
  spec.homepage      = "https://github.com/carld/continue"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
