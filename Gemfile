source "https://gems.railsc.ru"
source "https://rubygems.org"

if RUBY_VERSION < '2'
  gem 'mime-types', '< 3.0'
  gem 'json', '< 2.0.0'
  gem 'rack', '< 2.0.0'
  gem 'public_suffix', '< 1.5.0'
  gem 'pg', '< 0.19.0'
  gem "pry-debugger", ">= 0.2.3"
  gem 'nokogiri', '< 1.7.0'
  gem 'dry-configurable', '< 0.6.2'
else
  gem "test-unit"
  gem "pry-byebug"
end

# Specify your gem's dependencies in apress-api.gemspec
gemspec
