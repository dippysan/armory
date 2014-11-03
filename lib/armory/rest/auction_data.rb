require 'armory/arguments'
require 'armory/auction'
require 'armory/request'
require 'armory/rest/utils'
require 'armory/utils'

module Armory
  module REST
    module AuctionData
      include Armory::REST::Utils
      include Armory::Utils

      # Downloads and parses the requested auction file
      #
      # @param options [Hash] A customizable set of options.
      # - [Addressable::URI] Auction file location
      def auctiondata(auction_url, options = {})
        perform_with_object(:get, extract_url(auction_url), options, Armory::AuctionData)
      end

    end
  end
end
