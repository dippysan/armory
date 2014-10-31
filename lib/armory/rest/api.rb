require 'armory/rest/realmstatus'
require 'armory/rest/auction'
# require 'armory/rest/other-api-endpoints'

module Armory
  module REST
    module API
      include Armory::REST::RealmStatus
      include Armory::REST::Auction
    end
  end
end
