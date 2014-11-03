require 'memoizable'
require 'armory/null_object'
require 'armory/utils'
require 'armory/base'
require 'armory/auction_realm'
require 'armory/enumerable'

module Armory
  class AuctionData < Base
    include Armory::Enumerable
    include Armory::Utils
    include Memoizable

    # { "realm":{"name":"Kil'jaeden","slug":"kiljaeden"},
    #   "auctions":{"auctions":[
    #     {"auc":1118830215,"item":43385,"owner":"Rokhzin","ownerRealm":"Kil'jaeden","bid":1019246,"buyout":1084305,"quantity":1,"timeLeft":"VERY_LONG","rand":0,"seed":0,"context":0},

    def realm
      Realm.new(@region, @attrs[:realm])
    end
    memoize :realm

    def auctions
      @collection
    end

    # Initializes a new RealmStatus object
    #
    # @param attrs [Hash]
    # @return [Armory::RealmStatus]
    def initialize(region, attrs = {})
      super
      @collection = attrs.fetch(:auctions, []).fetch(:auctions, []).collect do |auctiondata|
        AuctionItem.new(@region, auctiondata)
      end
    end

  end
end
