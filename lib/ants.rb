require 'mongoid'
require 'mongoid_slug'
require 'devise'

module Ants
  require 'ants/engine'

  require "mongoid/fake_criteria"

  require "concerns/ants/id"
  require "concerns/ants/featurable"
  require "concerns/ants/hideable"
  require "concerns/ants/orderable"
  require "concerns/ants/meta"
  require "concerns/ants/slug"
  require "concerns/ants/publication"
  require "concerns/ants/sorted_relations"
  require "concerns/ants/versions"
  require "concerns/ants/content"

  require "constraints/redirects"
end