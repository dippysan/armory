lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'armory/version'

Gem::Specification.new do |spec|
  spec.add_dependency 'addressable', '~> 2.3'
  spec.add_dependency 'buftok', '~> 0.2.0'
  spec.add_dependency 'equalizer', '~> 0.0.9'
  spec.add_dependency 'faraday', '~> 0.9.0'
  spec.add_dependency 'http', '~> 0.6.0'
  spec.add_dependency 'http_parser.rb', '~> 0.6.0'
  spec.add_dependency 'json', '~> 1.8'
  spec.add_dependency 'memoizable', '~> 0.4.0'
  spec.add_dependency 'naught', '~> 1.0'
  spec.add_dependency 'simple_oauth', '~> 0.3.0'
  spec.add_development_dependency 'bundler', '~> 1.0'
  spec.authors = ['David Peterson']
  spec.description = 'A Ruby interface to the Blizzard Armory API.'
  spec.email = %w(dp@vivitec.com.au)
  spec.files = %w(.yardopts CHANGELOG.md CONTRIBUTING.md LICENSE.md README.md armory.gemspec) + Dir['lib/**/*.rb']
  spec.homepage = 'https://github.com/dippysan/armory'
  spec.licenses = %w(MIT)
  spec.name = 'armory'
  spec.require_paths = %w(lib)
  spec.required_rubygems_version = '>= 1.3.5'
  spec.summary = spec.description
  spec.version = Armory::Version
end
