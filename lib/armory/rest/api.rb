require 'armory/rest/realmstatus'
require 'armory/rest/auction'
require 'armory/rest/auction_data'
require 'armory/rest/character'
require 'armory/rest/achievement_data'
require 'armory/rest/talent_data'
require 'armory/rest/guild'
# require 'armory/rest/other-api-endpoints'

module Armory
  module REST
    module API
      include Armory::REST::RealmStatus
      include Armory::REST::Auction
      include Armory::REST::AuctionData
      include Armory::REST::Character
      include Armory::REST::AchievementData
      include Armory::REST::TalentData
      include Armory::REST::Guild
    end
  end
end
