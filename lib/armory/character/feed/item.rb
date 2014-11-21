require 'armory/meta_methods'
require 'armory/timestamp'

ITEM_CRITERIA    = "CRITERIA"
ITEM_ACHIEVEMENT = "ACHIEVEMENT"
ITEM_BOSSKILL    = "BOSSKILL"
ITEM_LOOT        = "LOOT"

module Armory
  class Character::Feed; end
  class Character::Feed::Item < Armory::MetaMethods
    include Timestamp

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
