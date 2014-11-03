require 'memoizable'
require 'armory/null_object'
require 'armory/utils'
require 'armory/base'
require 'armory/realm'
require 'armory/enumerable'

module Armory
  class AuctionData < Base
    include Armory::Enumerable
    include Armory::Utils
    include Memoizable

    # @return [Hash]
    attr_reader :attrs
    alias_method :to_h, :attrs
    alias_method :to_hash, :to_h

    def auctions
      @collection
    end

    # Initializes a new RealmStatus object
    #
    # @param attrs [Hash]
    # @return [Armory::RealmStatus]
    def initialize(region, attrs = {})
      super
      @collection = @attrs.fetch(:auctions, []).collect do |realm|
        AuctionData.new(@region, realm)
      end
    end

  end
end
