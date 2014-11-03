require 'armory/basic_realm'
require 'armory/world_zone'

module Armory
  class AuctionItem < Base
    include Equalizer.new(:region, :auc)

    # {"auc":594341719,"item":76507,"owner":"Miseur","ownerRealm":"Exodar","bid":238042,"buyout":250571,
    #  "quantity":1,"timeLeft":"SHORT","rand":0,"seed":0,"context":0},

    # @return [String]
    attr_reader :owner, :timeLeft
    alias_method :timeleft, :timeLeft
    # @return [Integer]
    attr_reader :auc, :item, :bid, :buyout, :quantity, :rand, :seed, :context
    alias_method :id, :auc

    object_attr_reader :AuctionRealm, :ownerRealm, target_alias: :name
    alias_method :realm, :ownerRealm
    alias_method :ownerrealm, :ownerRealm


  end
end
