require 'armory/meta_methods'
require 'armory/timestamp'


module Armory
  class Data::Feed::News < Armory::MetaMethods
    include Timestamp

    ITEM_LOOT              = "itemLoot"
    ITEM_PURCHASE          = "itemPurchase"
    ITEM_PLAYERACHIEVEMENT = "playerAchievement"
    GUILD_ACHIEVEMENT      = "guildAchievement"
    GUILD_CREATED          = "guildCreated"

    def self.create(attrs = {})
      case attrs.fetch(:type)
        when ITEM_LOOT
          Data::Feed::Item::Loot.new(attrs)
        when ITEM_PURCHASE
          Data::Feed::Item::Loot.new(attrs)
        when ITEM_PLAYERACHIEVEMENT
          Data::Feed::Item::Achievement.new(attrs)
        when GUILD_ACHIEVEMENT
          Data::Feed::Item::Achievement.new(attrs)
        when GUILD_CREATED
          # TODO
          # raise NotImplementedError
          News.new(attrs)
      end
    end

    attr_reader :type


  end
end
