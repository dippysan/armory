require 'armory/arguments'
require 'armory/auction'
require 'armory/request'
require 'armory/rest/utils'
require 'armory/utils'

module Armory
  module REST
    module AuctionFile
      include Armory::REST::Utils
      include Armory::Utils

      # Downloads the requested auction file
      #
      # @return [Armory::Auction] Auction file location
      # @param options [Hash] A customizable set of options.
      #  - realms : list of realms to limit to
      def auction_file(auction_url, options = {})
        perform_with_object(:get, "/wow/auction/data/#{extract_auction_file_url(auction_url)}", options, Armory::Auction)
      end

    end
  end
end
