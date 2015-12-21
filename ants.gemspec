# coding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'ants/version'

Gem::Specification.new do |s|
  s.name        = 'ants'
  s.version     = Ants::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = [ 'Alexander Kravets' ]
  s.email       = 'alex@slatestudio.com'
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/slate-studio/ants'
  s.summary     = 'Collection of concerns for Rails + Mongoid + Character web development'
  s.description = <<-DESC
Collection of concerns and helpers for Rails + Mongoid + Character web development
  DESC

  s.rubyforge_project = 'ants'
  s.files             = `git ls-files`.split("\n")
  s.require_paths     = [ 'lib' ]
  s.test_files        = s.files.grep(%r{^(test|spec|features)/})

  s.add_dependency('mongoid',      '>= 4.0'  )
  s.add_dependency('mongoid-slug', '>= 4.0.0')
  s.add_dependency('devise')

  s.add_development_dependency('rails',       [ '>= 4.2'   ])
  s.add_development_dependency('bundler', '~> 1.9')
  s.add_development_dependency('rake',    '~> 10.0')

  s.add_development_dependency('capybara-webkit')
  s.add_development_dependency('minitest-rails-capybara')
  s.add_development_dependency('database_cleaner')
end