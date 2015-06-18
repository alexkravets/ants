module Ants
  module Versions
    extend ActiveSupport::Concern

    included do

      # returns list of available object versions, requires
      # include Mongoid::History::Trackable to be configured
      def _document_versions
        hash = {}

        history_tracks.only(:created_at, :version).collect do |h|
          hash[h.version] = "Version #{ h.version } — #{ h.created_at }"
        end

        if hash.empty?
          hash = { '' => '--' }
        end

        return hash
      end

    end
  end
end