# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gprrr/version'

Gem::Specification.new do |spec|
  spec.name          = 'gprrr'
  spec.version       = Gprrr::VERSION
  spec.authors       = ['Gregory Romé']
  spec.email         = ['gregory.rome@gmail.com']

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.summary       = %q{GPR's Rails Resources.}
  spec.description   = %q{Helpers, templates and generators that support standard rails gem features.}
  spec.homepage      = 'https://github.com/gpr/gprrr'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'ruby-progressbar'
  spec.add_dependency 'configatron'
  spec.add_dependency 'mail'
  spec.add_dependency 'rails', '~> 4.2'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'minitest-reporters'
  spec.add_development_dependency 'ci_reporter_minitest'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-rcov'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'yard-minitest-spec'
  spec.add_development_dependency 'redcarpet'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'ptools'
end
