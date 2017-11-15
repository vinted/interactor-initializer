# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'interactor/initializer/version'

Gem::Specification.new do |spec|
  spec.name = 'interactor-initializer'
  spec.platform = Gem::Platform::RUBY
  spec.version = Interactor::Initializer::VERSION
  spec.authors = ['Šarūnas Kūjalis']
  spec.email = ['admin@vinted.com']
  spec.summary = 'Dry interactor initializer'
  spec.homepage = 'https://github.com/vinted/interactor-initializer'
  spec.license = 'MIT'

  spec.files = `git ls-files`.split($/)
  spec.test_files = `git ls-files -- {spec}/*`.split("\n")
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
