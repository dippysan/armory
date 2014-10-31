require 'armory/rest/realmstatus'
require 'armory/rest/auction'
require 'armory/rest/auction_file'
# require 'armory/rest/other-api-endpoints'

module Armory
  module REST
    module API
      include Armory::REST::RealmStatus
      include Armory::REST::Auction
      include Armory::REST::AuctionFile
    end
  end
end
