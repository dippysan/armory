require 'armory/basic_realm'
require 'armory/world_zone'

module Armory
  class Realm < Armory::BasicRealm

    # @return [String]
    attr_reader :name, :battlegroup, :locale, :timezone, :type, :population
    # @return [Boolean]
    predicate_attr_reader :queue, :status

    object_attr_reader :WorldZone, :wintergrasp
    object_attr_reader :WorldZone, :'tol-barad', method_alias: :tol_barad
    alias_method :tolbarad, :tol_barad

    # @return [Array<Armory::BasicRealm>]
    def connected_realms
      @attrs.fetch(:connected_realms, []).collect do |realmslug|
        BasicRealm.new(@region, slug: realmslug)
      end
    end
    memoize :connected_realms
    alias_method :connected, :connected_realms
    alias_method :connectedrealms, :connected_realms
end
end
