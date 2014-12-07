# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spider/version'

Gem::Specification.new do |spec|
  spec.name          = "spider"
  spec.version       = Spider::VERSION
  spec.authors       = ["alexander sanchez"]
  spec.email         = ["asanchez.dev@gmail.com"]
  spec.summary       = %q{web crawler}
  spec.description   = %q{web crawler made in ruby}
  spec.homepage      = "http://spider.github.io"
  spec.license       = "MIT"
  spec.bindir        = "bin"
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'term-ansicolor', '~> 1.3'
  spec.add_dependency 'mongo', '~> 1.3'
  spec.add_dependency 'mongoid', '~> 4'
  spec.add_dependency 'thor', '~> 0.19'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
