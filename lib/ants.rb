require "mongoid"
require "mongoid_slug"
require 'mongoid_search'
require "devise"
require "meta-tags"

module Ants
  require "ants/engine"
  require "ants/routing"
  require "mongoid/fake_criteria"
  require "concerns/ants/id"
  require "concerns/ants/featurable"
  require "concerns/ants/hideable"
  require "concerns/ants/orderable"
  require "concerns/ants/orderable_reverse"
  require "concerns/ants/meta"
  require "concerns/ants/slug"
  require "concerns/ants/sorted_relations"
  require "concerns/ants/versions"
  require "concerns/ants/scheduled"
  require "concerns/ants/content"
  require "constraints/redirects"
end
