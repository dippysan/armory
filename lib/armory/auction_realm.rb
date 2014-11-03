# Realm data in auctions.
# Separated into new class because not the same as a real realm:
# - name has spaces removed from realm name
# - no slug
# So we can't relate it to any other realms

module Armory
  class AuctionRealm < Base
    include Equalizer.new(:region, :name)

    # @return [String]
    attr_reader :name

  end
end
