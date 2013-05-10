# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tk/parallelcoordinates/version'

Gem::Specification.new do |spec|
	spec.name          = "tk-parallelcoordinates"
	spec.version       = Tk::ParallelCoordinates::VERSION
	spec.summary       = %q{A Parallel Coordinates widget for Tk}
	spec.description   = %q{This provides a rich Tk widget for displaying data across multiple axes with scaling.}
	spec.email         = ["rubygems@chrislee.dhs.org"]
	spec.authors       = ["chrislee35"]
	spec.homepage      = "https://rubyspecs.org/specs/tk-parallelcoordinates"
	spec.license       = "MIT"

	spec.files         = `git ls-files`.split($/)
	spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
	spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
	spec.require_paths = ["lib"]

	spec.add_development_dependency "bundler", "~> 1.3"
	spec.add_development_dependency "rake"
	
#	spec.add_runtime_dependency "tk"
	
	#spec.signing_key   = "#{File.dirname(__FILE__)}/../gem-private_key.pem"
	#spec.cert_chain    = ["#{File.dirname(__FILE__)}/../gem-public_cert.pem"]
	spec.test_files       = `git ls-files -- {test,spec,features}/*`.split("\n")
end
