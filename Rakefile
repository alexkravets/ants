# encoding: utf-8
require "rubygems"
require "bundler"

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end

Bundler::GemHelper.install_tasks

require 'rspec/core'
require 'rspec/core/rake_task'
task :default => :spec

RSpec::Core::RakeTask.new