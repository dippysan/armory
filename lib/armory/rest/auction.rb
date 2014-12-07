require 'armory/arguments'
require 'armory/auction'
require 'armory/request'
require 'armory/rest/utils'
require 'armory/utils'

module Armory
  module REST
    module Auction
      include Armory::REST::Utils
      include Armory::Utils

      # Auction APIs currently provide rolling batches of data about current auctions.
      # Fetching auction dumps is a two step process that involves checking a per-realm index file to
      # determine if a recent dump has been generated and then fetching the most recently generated dump
      # file if necessary.
      # This API resource provides a per-realm list of recently generated auction house data dumps.
      #
      # @return [Armory::Auction] Auction file location
      # @param realm_slug [string | Armory::Realm]
      # @param options [Hash] A customizable set of options.
      #  - realms : list of realms to limit to
      def auction(realm_slug, options = {})
        options = options.dup
        perform_with_object(:get, "/wow/auction/data/#{extract_slug(realm_slug)}", options, Armory::Auction)
      end

    end
  end
end
