require 'armory/character_feed_item'

module Armory
  class Character::Feed::Item::Loot < Character::Feed::Item

    attr_reader :itemId
    alias_method :item_id, :itemId

  end
end
