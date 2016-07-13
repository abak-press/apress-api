source "https://gems.railsc.ru"
source "https://rubygems.org"

group :development, :test do
  gem "combustion", github: "abak-press/combustion"
end

if RUBY_VERSION < '2'
  gem 'mime-types', '< 3.0'
  gem 'migration_comments', '= 0.3.2'
  gem 'json', '< 2.0.0'
  gem 'rack', '< 2.0.0'
end

# Specify your gem's dependencies in apress-api.gemspec
gemspec
