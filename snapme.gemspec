# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'snapme/version'

Gem::Specification.new do |gem|
  gem.name          = 'snapme'
  gem.version       = Snapme::Version
  gem.authors       = ['Jay Hayes']
  gem.email         = ['ur@iamvery.com']
  gem.description   = %q{Share yourself with your team}
  gem.summary       = %q{Share yourself with your team}
  gem.homepage      = 'https://github.com/iamvery/snapme'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = %w(lib)

  gem.add_dependency 'curb',              '~>0.8'
  gem.add_development_dependency 'rspec', '~>2.14'
end
