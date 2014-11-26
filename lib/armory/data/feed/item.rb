require 'armory/meta_methods'
require 'armory/timestamp'

module Armory
  class Data::Feed; end
  class Data::Feed::Item < Armory::MetaMethods
    include Timestamp

    # For guild news feed
    attr_reader :character

    ITEM_CRITERIA    = "CRITERIA"
    ITEM_ACHIEVEMENT = "ACHIEVEMENT"
    ITEM_BOSSKILL    = "BOSSKILL"
    ITEM_LOOT        = "LOOT"

    def self.create(attrs = {})
      case attrs.fetch(:type)
        when ITEM_CRITERIA
          Criteria.new(attrs)
        when ITEM_ACHIEVEMENT
          Achievement.new(attrs)
        when ITEM_BOSSKILL
          BossKill.new(attrs)
        when ITEM_LOOT
          Loot.new(attrs)
      end
    end

    attr_reader :type


  end
end
