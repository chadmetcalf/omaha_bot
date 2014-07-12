# require 'rbconfig'
# ruby 1.8.7 doesn't define RUBY_ENGINE
ruby_engine = 'ruby'
ruby_version = '2.1.0'
path = File.expand_path('..', __FILE__)
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/darwinning-0.0.2/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/dotenv-deployment-0.0.2/lib")
$:.unshift File.expand_path("#{path}/../#{ruby_engine}/#{ruby_version}/gems/dotenv-0.11.1/lib")
