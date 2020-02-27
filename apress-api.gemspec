lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'apress/api/version'

Gem::Specification.new do |spec|
  spec.name          = "apress-api"
  spec.version       = Apress::Api::VERSION
  spec.authors       = ["merkushin"]
  spec.email         = ["merkushin.m.s@gmail.com"]
  spec.summary       = "Apress-Api"
  spec.homepage      = "https://github.com/abak-press/apress-api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.5'

  spec.add_runtime_dependency "rails", ">= 4.2", "< 6.1.0"
  spec.add_runtime_dependency 'pg'
  spec.add_runtime_dependency "api-auth", ">= 1.3.1"
  spec.add_runtime_dependency "oj", ">= 2.9.9"
  spec.add_runtime_dependency "multi_json", ">= 1.11.2"
  spec.add_runtime_dependency "jbuilder", ">= 2.3.1"
  spec.add_runtime_dependency "attr_extras", ">= 4.4.0"
  spec.add_runtime_dependency 'swagger-core', '>= 0.3.0'
  spec.add_runtime_dependency 'interactor'
  spec.add_runtime_dependency 'pundit'
  spec.add_runtime_dependency 'addressable', '>= 2.4.0'

  spec.add_runtime_dependency 'resque-integration'
  spec.add_runtime_dependency 'apress-documentation', '>= 0.2.0'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", ">= 3.2"
  spec.add_development_dependency "rspec-rails", ">= 3.2"
  spec.add_development_dependency "combustion", ">= 0.5.4"
  spec.add_development_dependency "appraisal"
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "simplecov", ">= 0.9"
  spec.add_development_dependency "factory_girl_rails", ">= 4.5"
  spec.add_development_dependency "json-schema"
  spec.add_development_dependency "test-unit"
  spec.add_development_dependency "mock_redis"
  spec.add_development_dependency 'pry-byebug'
end
