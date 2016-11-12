require 'armory/arguments'
require 'armory/request'
require 'armory/rest/utils'
require 'armory/utils'

module Armory
  module REST
    module RealmStatus
      include Armory::REST::Utils
      include Armory::Utils

      # The realm status API allows developers to retrieve realm status information.
      # This information is limited to whether or not the realm is up, the type and state of the realm,
      # the current population, and the status of the two world PvP zones.
      #
      # @return [Array<Armory::RealmStatus>] Realm statuses
      # @param options [Hash] A customizable set of options.
      #  - realms : list of realms to limit to
      def realm_status(options = {})
        options = options.dup
        perform_with_objects(:get, '/wow/realm/status', options, Armory::Realm, :realms)
      end

      def realm_status_json(options = {})
        options = options.dup
        perform(:get, '/wow/realm/status', options)
      end

      alias_method :status, :realm_status
    end
  end
end
