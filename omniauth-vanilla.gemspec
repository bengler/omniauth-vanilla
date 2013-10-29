# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'omniauth-vanilla/version'

Gem::Specification.new do |gem|
  gem.name          = "omniauth-vanilla"
  gem.version       = OmniAuth::Vanilla::VERSION
  gem.authors       = ["Alexander Staubo"]
  gem.email         = ["alex@bengler.no"]
  gem.description   = 
  gem.summary       = %q{OmniAuth OAuth 2 strategy for Vanilla (http://github.com/bengler/vanilla).}
  gem.homepage      = "https://github.com/vanilla/omniauth-vanilla"

  gem.add_runtime_dependency     'omniauth', '~> 1.1.4'
  gem.add_runtime_dependency     'omniauth-oauth2', '~> 1.1.0'
  gem.add_runtime_dependency     'oauth'
  gem.add_dependency             'multi_json'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ["lib"]
end
